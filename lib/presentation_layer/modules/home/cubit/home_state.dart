import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import 'package:minhaloja/infra/infra.dart';

enum HomeAction {
  none,
  loading,
  creating,
  restaurantSuccessfully,
  categorySuccessfully,
  productSuccessfully,
}

class HomeState extends Equatable {
  final Failure? failure;
  final bool loading;
  final List<ProductDTO>? itens;
  final List<CategoryEntity>? categories;
  final RestaurantEntity? restaurant;
  final UnmodifiableSetView<HomeAction> actions;

  HomeState({
    this.failure,
    this.loading = true,
    this.restaurant,
    this.itens,
    this.categories,
    Set<HomeAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  HomeState copyWith({
    Failure? failure,
    bool? loading,
    List<ProductDTO>? itens,
    List<CategoryEntity>? categories,
    RestaurantEntity? restaurant,
    Set<HomeAction>? actions,
  }) {
    return HomeState(
      actions: actions ?? this.actions,
      loading: loading ?? this.loading,
      itens: itens ?? this.itens,
      categories: categories ?? this.categories,
      restaurant: restaurant ?? this.restaurant,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        loading,
        itens,
        categories,
        restaurant,
        actions,
      ];
}
