import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';

import 'package:quickfood/infra/infra.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetRestaurantUseCase _getRestaurantUseCase;
  final GetCategoryUseCase _getCategoryUseCase;
  final GetProductUseCase _getProductUseCase;

  HomeCubit(
    this._getRestaurantUseCase,
    this._getCategoryUseCase,
    this._getProductUseCase,
  ) : super(HomeState());

  Future<void> getFeaturedItens({
    required String restaurantId,
  }) async {
    update(loading: true);

    final request = await _getProductUseCase(restaurantId: restaurantId);

    request.result(
      (product) {
        emit(state.copyWith(itens: product));
        update(
          actions: {HomeAction.productSuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  Future<void> getCategoriesItens({
    required String restaurantId,
  }) async {
    update(loading: true);

    final request = await _getCategoryUseCase(restaurantId: restaurantId);

    request.result(
      (categories) {
        emit(state.copyWith(categories: categories));
        update(
          actions: {HomeAction.categorySuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  List<ProductDTO> featuredItens({required maxItens}) {
    var countItens = 0;
    return state.itens?.where((product) {
          countItens++;
          if (countItens <= maxItens) {
            return true;
          }
          return false;
        }).toList() ??
        [];
  }

  Future<void> getRestaurant({required String name}) async {
    update(loading: true);

    final request = await _getRestaurantUseCase(name: name);

    request.result(
      (restaurant) {
        emit(
          state.copyWith(restaurant: restaurant),
        );
        update(
          actions: {HomeAction.restaurantSuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  void update({
    bool loading = false,
    Failure? failure,
    Set<HomeAction>? actions,
  }) {
    Set<HomeAction> newActions = actions ??
        state.actions.difference(
          {HomeAction.creating},
        );
    if (loading) {
      newActions = newActions.union({HomeAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
