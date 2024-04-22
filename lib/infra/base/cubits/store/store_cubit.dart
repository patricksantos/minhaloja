import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import '../../../infra.dart';

class StoreCubit extends Cubit<StoreState> {
  final GetFormPaymentUseCase _getFormPaymentUseCase;

  StoreCubit(
    this._getFormPaymentUseCase,
  ) : super(StoreState()) {
    getStoreType(storeType: StoreType.delivery); // TODO: Aqui defino qual o tipo de site vai ser
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
