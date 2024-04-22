import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhaloja/infra/infra.dart';

import 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryState());

  void update({
    bool loading = false,
    Failure? failure,
    Set<DeliveryAction>? actions,
  }) {
    Set<DeliveryAction> newActions = actions ??
        state.actions.difference(
          {DeliveryAction.creating},
        );
    if (loading) {
      newActions = newActions.union({DeliveryAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
