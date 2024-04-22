import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:quickfood/infra/infra.dart';

enum LoginAction {
  none,
  loading,
  creating,
}

class LoginState extends Equatable {
  final Failure? failure;
  final User? currentUser;
  final UnmodifiableSetView<LoginAction> actions;

  LoginState({
    this.failure,
    this.currentUser,
    Set<LoginAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  LoginState copyWith({
    Failure? failure,
    User? currentUser,
    Set<LoginAction>? actions,
  }) {
    return LoginState(
      currentUser: currentUser ?? this.currentUser,
      actions: actions ?? this.actions,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        currentUser,
        actions,
      ];
}
