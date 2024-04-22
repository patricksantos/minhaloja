import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'package:minhaloja/data_layer/data_layer.dart';

import '../../../infra.dart';

enum CartAction {
  none,
  creating,
  orderSuccessfully,
}

class CartState extends Equatable {
  final Failure? failure;
  final List<ProductDTO> products;
  final List<ProductListCartDTO> productListCart;
  final UnmodifiableSetView<CartAction> actions;

  CartState({
    this.failure,
    this.products = const [],
    this.productListCart = const [],
    Set<CartAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  CartState copyWith({
    Failure? failure,
    AddressDTO? address,
    List<ProductDTO>? products,
    List<ProductListCartDTO>? productListCart,
    Set<CartAction>? actions,
  }) {
    return CartState(
      actions: actions ?? this.actions,
      products: products ?? this.products,
      productListCart: productListCart ?? this.productListCart,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        products,
        productListCart,
        actions,
      ];
}
