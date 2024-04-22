import 'package:quickfood/domain_layer/domain_layer.dart';

class UserDTO extends UserEntity {
  UserDTO({
    super.id,
    super.authToken,
    super.email,
    super.phoneNumber,
    super.username,
    super.password,
    super.isAnonymous,
  });

  UserDTO copyWith({
    String? id,
    String? authToken,
    String? email,
    String? phoneNumber,
    String? username,
    String? password,
    bool? isAnonymous,
  }) {
    return UserDTO(
      id: id ?? this.id,
      authToken: authToken ?? this.authToken,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      password: password ?? this.password,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'authToken': authToken,
      'email': email,
      'phoneNumber': phoneNumber,
      'username': username,
      'password': password,
      'isAnonymous': isAnonymous,
    };
  }

  factory UserDTO.fromJson(Map<String, dynamic> map) {
    return UserDTO(
      id: map['id'] as String,
      authToken: map['authToken'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      isAnonymous:
          map['isAnonymous'] != null ? map['isAnonymous'] as bool : null,
    );
  }
}
