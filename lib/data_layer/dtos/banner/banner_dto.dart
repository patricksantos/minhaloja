import 'package:minhaloja/domain_layer/entities/banner/banner_entity.dart';

class BannerDTO extends BannerEntity {
  BannerDTO({
    required super.id,
    required super.image,
    required super.productUrl,
  });

  BannerDTO copyWith({
    String? id,
    String? image,
    String? productUrl,
  }) {
    return BannerDTO(
      id: id ?? this.id,
      image: image ?? this.image,
      productUrl: productUrl ?? this.productUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'productUrl': productUrl,
    };
  }

  factory BannerDTO.fromJson(Map<String, dynamic> map) {
    return BannerDTO(
      id: map['id'] as String,
      image: map['image'] as String,
      productUrl: map['product_url'] as String,
    );
  }
}
