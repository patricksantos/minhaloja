import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'package:quickfood/data_layer/data_layer.dart';

import 'package:quickfood/infra/infra.dart';

enum OrderAction {
  none,
  loading,
  creating,
  orderSuccessfully,
}

class OrderState extends Equatable {
  final Failure? failure;
  final List<ProductListCartDTO> productOrderList;
  final UnmodifiableSetView<OrderAction> actions;

  OrderState({
    this.failure,
    this.productOrderList = const [],
    Set<OrderAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  OrderState copyWith({
    Failure? failure,
    List<ProductListCartDTO>? productOrderList,
    Set<OrderAction>? actions,
  }) {
    return OrderState(
      productOrderList: productOrderList ?? this.productOrderList,
      actions: actions ?? this.actions,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        productOrderList,
        actions,
      ];
}
