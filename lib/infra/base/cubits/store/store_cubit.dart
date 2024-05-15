import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import '../../../infra.dart';

class StoreCubit extends Cubit<StoreState> {
  final GetFormPaymentUseCase _getFormPaymentUseCase;
  final GetRestaurantUseCase _getRestaurantUseCase;
  final GetOrderUseCase _getOrderUseCase;
  final UpdateOrderUseCase _updateOrderUseCase;

  StoreCubit(
    this._getFormPaymentUseCase,
    this._getOrderUseCase,
    this._getRestaurantUseCase,
    this._updateOrderUseCase,
  ) : super(StoreState()) {
    getStoreType(
        storeType: StoreType
            .delivery); // TODO: Aqui defino qual o tipo de site vai ser
  }

  Future<void> updateOrder({
    required String orderId,
    bool? paidOut,
    StatusOrder? status,
    StoreType? storeType,
  }) async {
    final request = await _updateOrderUseCase(
      orderId: orderId,
      paidOut: paidOut,
      status: status,
      storeType: storeType,
    );

    request.result(
      (_) async {
        update(actions: {StoreAction.updateRestaurantSuccessfully});
      },
      (e) => update(
        failure: e,
        actions: {StoreAction.updateRestaurantSuccessfully},
      ),
    );
  }

  Future<List<OrderDTO>> getOrder() async {
    update(loading: true);

    final request = await _getOrderUseCase(
      userId: 'userId',
      storeType: '',
    );

    return request.result(
      (list) {
        emit(state.copyWith(orderList: []));
        emit(state.copyWith(orderList: list));
        update(actions: {StoreAction.orderSuccessfully});
        return list ?? [];
      },
      (e) {
        update(
          failure: e,
          actions: {StoreAction.orderSuccessfully},
        );
        return [];
      },
    );
  }

  Future<void> getRestaurant() async {
    update(loading: true);
    final request = await _getRestaurantUseCase();
    request.result(
      (restaurant) {
        emit(
          state.copyWith(restaurant: restaurant),
        );
        update(actions: {StoreAction.restaurantSuccessfully});
      },
      (e) {
        update(failure: e);
      },
    );
  }

  Future<void> getFormPayment() async {
    update(loading: true);

    final request = await _getFormPaymentUseCase();

    request.result(
      (list) {
        update(
          actions: {StoreAction.formPaymentSuccessfully},
        );
        emit(
          state.copyWith(
            listFormPayment: list,
            formPayment: list?.reversed.first,
          ),
        );
      },
      (e) => update(failure: e),
    );
  }

  void getStoreType({
    required StoreType storeType,
  }) {
    emit(
      state.copyWith(storeType: storeType),
    );
  }

  void onChangeFormPayment({
    required FormPaymentDTO formPayment,
  }) {
    emit(
      state.copyWith(formPayment: formPayment),
    );
  }

  void update({
    bool loading = false,
    Failure? failure,
    Set<StoreAction>? actions,
  }) {
    Set<StoreAction> newActions = actions ??
        state.actions.difference(
          {
            StoreAction.creating,
          },
        );
    if (loading) {
      newActions = newActions.union({StoreAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
