import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'package:quickfood/domain_layer/domain_layer.dart';
import 'package:quickfood/infra/infra.dart';

enum QrCodeAction {
  none,
  loading,
  creating,
}

class QrCodeState extends Equatable {
  final Failure? failure;
  final UnmodifiableSetView<QrCodeAction> actions;

  QrCodeState({
    this.failure,
    Set<QrCodeAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  QrCodeState copyWith({
    Failure? failure,
    List<ProductEntity>? itens,
    List<CategoryEntity>? categories,
    RestaurantEntity? restaurant,
    Set<QrCodeAction>? actions,
  }) {
    return QrCodeState(
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
