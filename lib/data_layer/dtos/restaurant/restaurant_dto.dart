import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';

class RestaurantDTO extends RestaurantEntity {
  RestaurantDTO({
    super.id,
    super.user,
    super.address,
    super.addressId,
    required super.userId,
    required super.name,
    required super.logoUrl,
    required super.backgroundUrl,
    required super.url,
    required super.segment,
    required super.cnpj,
    required super.phoneNumber,
    required super.description,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'address': address,
      'user_id': userId,
      'address_id': addressId,
      'url': url,
      'logo_url': logoUrl,
      'background_url': backgroundUrl,
      'name': name,
      'segment': segment,
      'description': description,
      'cnpj': cnpj,
      'phone_number': phoneNumber,
    };
  }

  factory RestaurantDTO.fromJson(Map<String, dynamic> map) {
    return RestaurantDTO(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      addressId: map['address_id'] as String,
      user: map['user'] as UserDTO?,
      address: map['address'] as AddressDTO?,
      url: map['url'] as String,
      logoUrl: map['logo_url'] as String,
      backgroundUrl: map['background_url'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      segment: map['segment'] as String,
      cnpj: map['cnpj'] as String,
      phoneNumber: map['phone_number'] as String,
    );
  }
}
