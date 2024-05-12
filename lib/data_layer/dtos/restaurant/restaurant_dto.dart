import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

class RestaurantDTO extends RestaurantEntity {
  RestaurantDTO({
    super.id,
    super.user,
    super.address,
    super.addressId,
    super.userId,
    required super.name,
    required super.logoUrl,
    required super.backgroundUrl,
    required super.url,
    required super.segment,
    required super.cnpj,
    required super.phoneNumber,
    required super.description,
    super.banner,
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
      'banner': banner != null
          ? banner!
              .map((x) => <String, dynamic>{
                    'id': x.id,
                    'image': x.image,
                    'productUrl': x.productUrl,
                  })
              .toList()
          : [],
    };
  }

  Map<String, dynamic> toUpdate() {
    return <String, dynamic>{
      if (id != '' && id != null) 'id': id,
      if (user != null) 'user': user,
      if (userId != '' && userId != null) 'user_id': userId,
      if (addressId != '' && addressId != null) 'address_id': addressId,
      if (url != '') 'url': url,
      if (logoUrl != '') 'logo_url': logoUrl,
      if (backgroundUrl != '') 'background_url': backgroundUrl,
      if (name != '') 'name': name,
      if (segment != '') 'segment': segment,
      if (description != '') 'description': description,
      if (cnpj != '') 'cnpj': cnpj,
      if (phoneNumber != '') 'phone_number': phoneNumber,
      // if (address != null) 'address': address,
      // if (banner != null)
      //   'banner': banner!
      //       .map((x) => <String, dynamic>{
      //             'id': x.id,
      //             'image': x.image,
      //             'productUrl': x.productUrl,
      //           })
      //       .toList(),
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
      // banner: List<BannerDTO>.from((map['banner'])),
      banner: map['banner'] != null && (map['banner'] as List).isNotEmpty
          ? (map['banner'] as List)
              .map((combo) => BannerDTO.fromJson(combo))
              .toList()
          : [],
    );
  }
}
