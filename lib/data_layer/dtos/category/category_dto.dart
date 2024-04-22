import 'package:minhaloja/domain_layer/domain_layer.dart';

class CategoryDTO extends CategoryEntity {
  CategoryDTO({
    super.id,
    required super.restaurantId,
    required super.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'restaurant_id': restaurantId,
      'name': name,
    };
  }

  factory CategoryDTO.fromJson(Map<String, dynamic> map) {
    return CategoryDTO(
      id: map['id'] as String,
      restaurantId: map['restaurant_id'] as String,
      name: map['name'] as String,
    );
  }
}
