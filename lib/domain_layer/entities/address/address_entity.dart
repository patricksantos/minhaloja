import 'package:uuid/uuid.dart';

class UserAddressEntity {
  String? id;
  final String userId;
  final String addressId;

  UserAddressEntity({
    this.id,
    required this.userId,
    required this.addressId,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }
}

class AddressEntity {
  String? id;
  final String city;
  final String zipCode;
  final String neighborhood;
  final String number;
  final String complement;
  final String country;
  final String street;
  final String state;

  AddressEntity({
    this.id,
    required this.city,
    required this.zipCode,
    required this.neighborhood,
    required this.number,
    required this.complement,
    required this.country,
    required this.street,
    required this.state,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }
}
