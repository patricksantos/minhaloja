import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:minhaloja/data_layer/data_layer.dart';

import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/infra/infra.dart';

enum ProductDetailsAction {
  none,
  loading,
  productSuccessfully,
  creating,
}

class ProductDetailsState extends Equatable {
  final Failure? failure;
  final ProductDTO? product;
  final UnmodifiableSetView<ProductDetailsAction> actions;

  ProductDetailsState({
    this.failure,
    this.product,
    Set<ProductDetailsAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  ProductDetailsState copyWith({
    Failure? failure,
    ProductDTO? product,
    List<ProductEntity>? itens,
    List<CategoryEntity>? categories,
    RestaurantEntity? restaurant,
    Set<ProductDetailsAction>? actions,
  }) {
    return ProductDetailsState(
      product: product ?? this.product,
      actions: actions ?? this.actions,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        product,
        failure,
        actions,
      ];
}
