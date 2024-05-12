import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/infra/infra.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final FirebaseAuth _firebaseAuth;
  final GetUserUseCase _getUserUseCase;
  final GetRestaurantUseCase _getRestaurantUseCase;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamController<bool> loadingStream = StreamController<bool>();

  DashboardCubit(
    this._firebaseAuth,
    this._getUserUseCase,
    this._getRestaurantUseCase,
  ) : super(DashboardState()) {
    init();
  }

  void init() async {
    update(loading: true);
    await _getRestaurant();
    await _getCurrentUser();
    update(loading: false);
  }

  void controlMenu() {
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void setPage(int page) {
    emit(state.copyWith(page: page));
  }

  Future<void> _getCurrentUser() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      final request = await _getUserUseCase(authToken: currentUser?.uid ?? '');

      request.result(
        (user) async {
          emit(state.copyWith(currentUser: user));
        },
        (e) => emit(state.copyWith(failure: e)),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> _getRestaurant() async {
    try {
      final request = await _getRestaurantUseCase();

      request.result(
        (restaurant) =>
            emit(state.copyWith(restaurant: restaurant, isFirstAccess: false)),
        (e) => emit(state.copyWith(isFirstAccess: true, failure: e)),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  void update({
    bool loading = false,
    Failure? failure,
    Set<DashboardAction>? actions,
  }) {
    Set<DashboardAction> newActions = actions ??
        state.actions.difference(
          {DashboardAction.creating},
        );
    if (loading) {
      newActions = newActions.union({DashboardAction.creating});
      loadingStream.add(true);
    } else {
      loadingStream.add(false);
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
