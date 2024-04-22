import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickfood/infra/infra.dart';

// import 'cart_state.dart';

class CartProductsCubit extends Cubit<CartState> {
  CartProductsCubit() : super(CartState());

  void update({
    bool loading = false,
    Failure? failure,
    Set<CartAction>? actions,
  }) {
    Set<CartAction> newActions = actions ??
        state.actions.difference(
          {CartAction.creating},
        );
    if (loading) {
      newActions = newActions.union({CartAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
