import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/infra/infra.dart';

import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductByIdUseCase _getProductByIdUseCase;

  ProductDetailsCubit(
    this._getProductByIdUseCase,
  ) : super(ProductDetailsState());

  Future<void> getProductDetails({
    required String productId,
  }) async {
    update(loading: true);
    final request = await _getProductByIdUseCase(productId: productId);

    request.result(
      (product) {
        emit(state.copyWith(product: product));
        update(actions: {ProductDetailsAction.productSuccessfully});
      },
      (e) => update(failure: e),
    );
  }

  void update({
    bool loading = false,
    Failure? failure,
    Set<ProductDetailsAction>? actions,
  }) {
    Set<ProductDetailsAction> newActions = actions ??
        state.actions.difference(
          {ProductDetailsAction.creating},
        );
    if (loading) {
      newActions = newActions.union({ProductDetailsAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
