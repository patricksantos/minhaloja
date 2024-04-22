import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/infra/infra.dart';

enum AuthAction {
  none,
  creating,
  userSuccessfully,
  restaurantSuccessfully,
  updateRestaurantSuccessfully,
  categorySuccessfully,
  productSuccessfully,
  cepSuccessfully,
  addressSuccessfully,
  updateAddressSuccessfully,
  createAddressSuccessfully,
  userAddressSuccessfully,
}

class AuthState extends Equatable {
  final Failure? failure;
  final UserEntity? user;
  final AddressDTO? address;
  final AddressDTO? userAddress;
  final UnmodifiableSetView<AuthAction> actions;

  AuthState({
    this.failure,
    this.user,
    this.address,
    this.userAddress,
    Set<AuthAction> actions = const {},
  }) : actions = UnmodifiableSetView(actions);

  AuthState copyWith({
    Failure? failure,
    UserEntity? user,
    AddressDTO? address,
    AddressDTO? userAddress,
    RestaurantEntity? restaurant,
    Set<AuthAction>? actions,
  }) {
    return AuthState(
      actions: actions ?? this.actions,
      user: user ?? this.user,
      address: address ?? this.address,
      userAddress: userAddress ?? this.userAddress,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        user,
        address,
        userAddress,
        actions,
      ];
}
