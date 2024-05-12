import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/entities.dart';

import '../../../infra.dart';

enum StoreAction {
  none,
  creating,
  formPaymentSuccessfully,
  restaurantSuccessfully,
}

class StoreState extends Equatable {
  final Failure? failure;
  final StoreType storeType;
  final List<FormPaymentDTO> listFormPayment;
  final FormPaymentDTO? formPayment;
  final RestaurantEntity? restaurant;
  final UnmodifiableSetView<StoreAction> actions;

  StoreState({
    this.failure,
    this.formPayment,
    this.restaurant,
    this.storeType = StoreType.none,
    this.listFormPayment = const [],
    Set<StoreAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  StoreState copyWith({
    Failure? failure,
    StoreType? storeType,
    RestaurantEntity? restaurant,
    AddressDTO? address,
    List<FormPaymentDTO>? listFormPayment,
    FormPaymentDTO? formPayment,
    Set<StoreAction>? actions,
  }) {
    return StoreState(
      actions: actions ?? this.actions,
      storeType: storeType ?? this.storeType,
      restaurant: restaurant ?? this.restaurant,
      listFormPayment: listFormPayment ?? this.listFormPayment,
      formPayment: formPayment ?? this.formPayment,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        storeType,
        restaurant,
        listFormPayment,
        formPayment,
        actions,
      ];
}
