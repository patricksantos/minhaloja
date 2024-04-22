import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';

import 'package:quickfood/infra/infra.dart';

import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final GetOrderUseCase _getOrderUseCase;

  OrderCubit(
    this._getOrderUseCase,
  ) : super(OrderState());

  Future<void> getOrder({
    required String userId,
    required StoreType storeType,
  }) async {
    if (userId != '') {
      update(loading: true);
      emit(state.copyWith(productOrderList: []));

      final request = await _getOrderUseCase(
        userId: userId,
        storeType: storeType == StoreType.none ? 'delivery' : storeType.name,
      );

      request.result(
        (list) {
          for (OrderDTO order in list ?? []) {
            for (var item in order.products) {
              _addCartOrder(product: item);
            }
          }
          update(
            actions: {OrderAction.orderSuccessfully},
          );
        },
        (e) => update(failure: e),
      );
    }
  }

  void _addCartOrder({
    required ProductDTO product,
  }) {
    ProductListCartDTO? result = state.productOrderList
        .where(
          ((element) =>
              element.productId == product.id &&
              element.products.first.orderId == product.orderId),
        )
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
          productOrderList: [
            ...state.productOrderList,
            item,
          ],
        ),
      );
    } else {
      final newList = state.productOrderList.map(
        (item) {
          if (item.productId == product.id &&
              item.products.first.orderId == product.orderId) {
            item.products.add(product);
            item.quantity = item.quantity + 1;
            item.order = product.orderId;
          }
          return item;
        },
      );
      state.productOrderList
          .toList()
          .sort((a, b) => a.order.compareTo(b.order));
      emit(
        state.copyWith(
          productOrderList: [
            ...newList,
          ],
        ),
      );
    }
  }

  void finishOrder() {
    emit(
      state.copyWith(
        productOrderList: [],
      ),
    );
  }

  void update({
    bool loading = false,
    Failure? failure,
    Set<OrderAction>? actions,
  }) {
    Set<OrderAction> newActions = actions ??
        state.actions.difference(
          {OrderAction.creating},
        );
    if (loading) {
      newActions = newActions.union({OrderAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
