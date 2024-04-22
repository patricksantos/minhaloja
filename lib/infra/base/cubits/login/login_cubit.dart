import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhaloja/infra/configs/network/response/failure.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final CreateUserUseCase _createUserUseCase;
  final FirebaseAuth _firebaseAuth;

  LoginCubit(
    this._createUserUseCase,
    this._firebaseAuth,
  ) : super(LoginState());

  Future<User?> getCurrentUser() async {
    try {
      emit(state.copyWith(currentUser: FirebaseAuth.instance.currentUser));
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<void> recoverPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<UserCredential?> signUp({
    required String password,
    required String email,
  }) async {
    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          emit(state.copyWith(currentUser: FirebaseAuth.instance.currentUser));
          return value;
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<void> registerUser({
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      UserCredential response =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await response.user?.updateDisplayName(name);
      await _createUser(
        email: email,
        authToken: response.user?.uid,
        isAnonymous: false,
        password: password,
        phoneNumber: '',
        username: name,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        debugPrint('usuario ja cadastrado');
      }
      debugPrint('error');
    }
  }

  Future<void> _createUser({
    required String email,
    required String phoneNumber,
    required String username,
    required String password,
    required String? authToken,
    required bool? isAnonymous,
  }) async {
    update(loading: true);

    final user = authToken != null
        ? UserDTO(
            email: email,
            phoneNumber: phoneNumber,
            username: username,
            password: password,
            authToken: authToken,
            isAnonymous: isAnonymous,
          )
        : UserDTO(
            email: email,
            phoneNumber: phoneNumber,
            username: username,
            password: password,
          );

    // criar user no firebase
    final request = await _createUserUseCase(user: user);

    request.result(
      (_) {},
      (e) => update(failure: e),
    );
  }

  void update({
    bool loading = false,
    Failure? failure,
    Set<LoginAction>? actions,
  }) {
    Set<LoginAction> newActions = actions ??
        state.actions.difference(
          {LoginAction.creating},
        );
    if (loading) {
      newActions = newActions.union({LoginAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
