import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickfood/infra/infra.dart';

import 'qrcode_state.dart';

class QrCodeCubit extends Cubit<QrCodeState> {
  QrCodeCubit() : super(QrCodeState());

  void update({
    bool loading = false,
    Failure? failure,
    Set<QrCodeAction>? actions,
  }) {
    Set<QrCodeAction> newActions = actions ??
        state.actions.difference(
          {QrCodeAction.creating},
        );
    if (loading) {
      newActions = newActions.union({QrCodeAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
