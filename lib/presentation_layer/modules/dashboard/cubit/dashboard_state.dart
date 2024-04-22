import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/entities.dart';

import 'package:minhaloja/infra/infra.dart';

enum DashboardAction {
  none,
  loading,
  creating,
}

class DashboardState extends Equatable {
  final Failure? failure;
  final UserDTO? currentUser;
  final bool isFirstAccess;
  final int page;
  final RestaurantEntity? restaurant;
  final UnmodifiableSetView<DashboardAction> actions;

  DashboardState({
    this.failure,
    this.currentUser,
    this.isFirstAccess = false,
    this.restaurant,
    this.page = 0,
    Set<DashboardAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  DashboardState copyWith({
    Failure? failure,
    UserDTO? currentUser,
    bool? isFirstAccess,
    int? page,
    RestaurantEntity? restaurant,
    Set<DashboardAction>? actions,
  }) {
    return DashboardState(
      actions: actions ?? this.actions,
      currentUser: currentUser ?? this.currentUser,
      restaurant: restaurant ?? this.restaurant,
      page: page ?? this.page,
      isFirstAccess: isFirstAccess ?? this.isFirstAccess,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        currentUser,
        restaurant,
        page,
        isFirstAccess,
        actions,
      ];
}
