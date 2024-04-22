import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'package:quickfood/domain_layer/domain_layer.dart';
import 'package:quickfood/infra/infra.dart';

enum DeliveryAction {
  none,
  loading,
  creating,
}

class DeliveryState extends Equatable {
  final Failure? failure;
  final UnmodifiableSetView<DeliveryAction> actions;

  DeliveryState({
    this.failure,
    Set<DeliveryAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  DeliveryState copyWith({
    Failure? failure,
    List<ProductEntity>? itens,
    List<CategoryEntity>? categories,
    RestaurantEntity? restaurant,
    Set<DeliveryAction>? actions,
  }) {
    return DeliveryState(
      actions: actions ?? this.actions,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        actions,
      ];
}
