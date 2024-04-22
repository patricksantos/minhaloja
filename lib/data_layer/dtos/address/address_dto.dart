import 'package:quickfood/domain_layer/domain_layer.dart';

class UserAddressDTO extends UserAddressEntity {
  UserAddressDTO({
    super.id,
    required super.userId,
    required super.addressId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'address_id': addressId,
    };
  }

  factory UserAddressDTO.fromJson(Map<String, dynamic> map) {
    return UserAddressDTO(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      addressId: map['address_id'] as String,
    );
  }
}

class AddressDTO extends AddressEntity {
  AddressDTO({
    super.id,
    required super.city,
    required super.zipCode,
    required super.neighborhood,
    required super.number,
    required super.complement,
    required super.country,
    required super.street,
    required super.state,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'city': city,
      'zipCode': zipCode,
      'neighborhood': neighborhood,
      'number': number,
      'complement': complement,
      'country': country,
      'street': street,
      'state': state,
    };
  }

  factory AddressDTO.fromJson(Map<String, dynamic> map) {
    return AddressDTO(
      id: map['id'] as String,
      city: map['city'] as String,
      zipCode: map['zipCode'] as String,
      neighborhood: map['neighborhood'] as String,
      number: map['number'] as String,
      complement: map['complement'] as String,
      country: map['country'] as String,
      street: map['street'] as String,
      state: map['state'] as String,
    );
  }
}
