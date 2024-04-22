import 'package:uuid/uuid.dart';

class UserEntity {
  String? id;
  String? authToken;
  String? email;
  String? phoneNumber;
  String? username;
  String? password;
  bool? isAnonymous;

  UserEntity({
    this.id,
    this.authToken,
    this.email,
    this.phoneNumber,
    this.username,
    this.password,
    this.isAnonymous,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
    authToken = authToken ?? uuid.v4();
    isAnonymous = isAnonymous ?? false;
  }
}
