import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'package:quickfood/data_layer/data_layer.dart';

import '../../../infra.dart';

enum StoreAction {
  none,
  creating,
  formPaymentSuccessfully,
}

class StoreState extends Equatable {
  final Failure? failure;
  final StoreType storeType;
  final List<FormPaymentDTO> listFormPayment;
  final FormPaymentDTO? formPayment;
  final UnmodifiableSetView<StoreAction> actions;

  StoreState({
    this.failure,
    this.formPayment,
    this.storeType = StoreType.none,
    this.listFormPayment = const [],
    Set<StoreAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  StoreState copyWith({
    Failure? failure,
    StoreType? storeType,
    AddressDTO? address,
    List<FormPaymentDTO>? listFormPayment,
    FormPaymentDTO? formPayment,
    Set<StoreAction>? actions,
  }) {
    return StoreState(
      actions: actions ?? this.actions,
      storeType: storeType ?? this.storeType,
      listFormPayment: listFormPayment ?? this.listFormPayment,
      formPayment: formPayment ?? this.formPayment,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        storeType,
        listFormPayment,
        formPayment,
        actions,
      ];
}
