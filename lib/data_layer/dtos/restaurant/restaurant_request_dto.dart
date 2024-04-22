import 'package:minhaloja/data_layer/data_layer.dart';

class RestaurantRequestDTO extends RestaurantDTO {
  RestaurantRequestDTO({
    super.id,
    required super.address,
    required super.userId,
    required super.user,
    required super.name,
    required super.url,
    required super.logoUrl,
    required super.backgroundUrl,
    required super.segment,
    required super.cnpj,
    required super.phoneNumber,
    required super.description,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      "user_id": userId,
      "address_id": address?.id,
      'url': url.toLowerCase(),
      'logo_url': logoUrl,
      'background_url': backgroundUrl,
      'name': name.toLowerCase(),
      'description': description.toLowerCase(),
      'segment': segment.toLowerCase(),
      'cnpj': cnpj,
      'phone_number': phoneNumber.toString(),
    };
  }
}
