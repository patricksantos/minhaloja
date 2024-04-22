import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItensUseCase _getCartItensUseCase;
  final GetProductsStorageUseCase _getProductsUseCase;
  final SaveCartItensUseCase _saveCartItensUseCase;
  final DeleteCartItensUseCase _deleteCartItensUseCase;
  final CreateOrderUseCase _createOrderUseCase;

  CartCubit(
    this._getCartItensUseCase,
    this._getProductsUseCase,
    this._saveCartItensUseCase,
    this._deleteCartItensUseCase,
    this._createOrderUseCase,
  ) : super(CartState());

  void getListCartStorage() {
    _getProductsUseCase().then(
      (value) {
        emit(
          state.copyWith(products: value as List<ProductDTO>?),
        );
      },
    );
    _getCartItensUseCase().then(
      (value) {
        emit(
          state.copyWith(
            productListCart: value as List<ProductListCartDTO>?,
          ),
        );
      },
    );
  }

  void addCartProduct({
    required ProductDTO product,
  }) {
    ProductListCartDTO? result = state.productListCart
        .where(((element) => element.productId == product.id))
        .firstOrNull;
    if (result == null) {
      final item = ProductListCartDTO(
        productId: product.id!,
        restaurantId: product.restaurantId,
        quantity: 1,
        products: [product],
      );
      emit(
        state.copyWith(
          products: [...state.products, product],
          productListCart: [...state.productListCart, item].reversed.toList(),
        ),
      );
    } else {
      final newList = state.productListCart.map(
        (item) {
          if (item.productId == product.id) {
            item.products.add(product);
            item.quantity = item.quantity + 1;
          }
          return item;
        },
      ).toList();
      emit(
        state.copyWith(
          products: [...state.products, product],
          productListCart: newList,
        ),
      );
    }
    _saveCartItens(state.productListCart, state.products);
  }

  void addAllCartProducts({
    required List<ProductDTO> products,
  }) {
    final product = products.first;
    final productId = product.id;
    final restaurantId = product.restaurantId;
    ProductListCartDTO? result = state.productListCart
        .where(((element) => element.productId == productId))
        .firstOrNull;
    if (result == null) {
      final item = ProductListCartDTO(
        productId: productId!,
        restaurantId: restaurantId,
        quantity: products.length,
        products: [...products],
      );
      emit(
        state.copyWith(
          products: [...state.products, ...products],
          productListCart: [...state.productListCart, item].reversed.toList(),
        ),
      );
    } else {
      final newList = state.productListCart.map(
        (item) {
          if (item.productId == productId) {
            item.products.addAll(products);
            item.quantity = item.quantity + products.length;
          }
          return item;
        },
      ).toList();
      emit(
        state.copyWith(
          products: [...state.products, ...products],
          productListCart: newList,
        ),
      );
    }
    _saveCartItens(state.productListCart, state.products);
  }

  void removeCartProduct({
    required ProductDTO product,
  }) {
    List<ProductDTO> list = [];
    for (var item in state.products) {
      if (item.id != product.id) {
        list.add(item);
      }
    }
    bool flag = false;
    for (var item in state.products) {
      if (item.id == product.id && flag == true) {
        list.add(item);
      } else if (item.id == product.id) {
        flag = true;
      }
    }

    List<ProductListCartDTO> listCart = [];
    for (var item in state.productListCart) {
      if (item.productId == product.id) {
        item.products.removeLast();
        item.quantity = item.quantity - 1;
        if (item.products.isNotEmpty || item.quantity != 0) {
          listCart.add(item);
        }
      } else {
        listCart.add(item);
      }
    }
    emit(
      state.copyWith(
        products: list,
        productListCart: listCart,
      ),
    );
    _saveCartItens(listCart, list);
  }

  void _saveCartItens(
    List<ProductListCartDTO> productListCart,
    List<ProductDTO> products,
  ) {
    _deleteCartItensUseCase();
    _saveCartItensUseCase(
      productListCart: productListCart,
      products: products,
    );
  }

  Future<void> createOrder({
    required String userId,
    required String restaurantId,
    required StoreType storeType,
    required List<ProductListCartDTO> productOrderList,
    required List<FormPaymentDTO> listFormPayment,
    required FormPaymentDTO? formPayment,
  }) async {
    update(loading: true);

    var totalValue = 0.0;
    for (var element in state.products) {
      totalValue = totalValue + element.value;
    }

    final orderDTO = OrderDTO(
      restaurantId: restaurantId,
      productsId: [...state.products.map((e) => e.id!).toList()],
      totalValue: totalValue,
      storeType: storeType,
      userId: userId,
      paymentId: storeType == StoreType.menu
          ? listFormPayment.where((item) => item.name == 'Á vista').first.id ??
              ''
          : formPayment?.id ?? '',
    );

    final request = await _createOrderUseCase(order: orderDTO);

    request.result(
      (_) {
        emit(
          state.copyWith(
            products: [],
            productListCart: [],
          ),
        );
        _deleteCartItensUseCase();
        update(
          actions: {CartAction.orderSuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  void update({
    bool loading = false,
    Failure? failure,
    Set<CartAction>? actions,
  }) {
    Set<CartAction> newActions = actions ??
        state.actions.difference(
          {
            CartAction.creating,
          },
        );
    if (loading) {
      newActions = newActions.union({CartAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
