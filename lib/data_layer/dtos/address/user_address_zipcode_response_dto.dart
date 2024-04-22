import 'package:quickfood/domain_layer/domain_layer.dart';

class UserAddressByZipCodeResponseDTO extends UserAddressByZipCodeEntity {
  const UserAddressByZipCodeResponseDTO({
    required super.state,
    required super.city,
    required super.street,
    required super.neighborhood,
    required super.zipCode,
    required super.complement,
  });

  factory UserAddressByZipCodeResponseDTO.fromJson(Map<String, dynamic> json) {
    return UserAddressByZipCodeResponseDTO(
      state: json['uf'] ?? '',
      city: json['localidade'] ?? '',
      street: json['logradouro'] ?? '',
      neighborhood: json['bairro'] ?? '',
      zipCode: json['cep'] ?? '',
      complement: json['complemento'] ?? '',
    );
  }
}
