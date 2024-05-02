// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

import 'package:minhaloja/data_layer/dtos/combo/combo_dto.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import '../../../infra/utils.dart';

class ProductDTO extends ProductEntity {
  StatusOrder statusOrder = StatusOrder.none;
  String orderId = '';
  ProductDTO({
    super.id,
    super.quantity,
    super.status = true,
    super.note,
    super.emphasis = false,
    required super.restaurantId,
    required super.categoryId,
    required super.name,
    required super.description,
    required super.image,
    required super.combos,
    required super.value,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }

  ProductDTO copyWith({
    String? id,
    int? quantity,
    bool? status,
    bool? emphasis,
    String? restaurantId,
    String? categoryId,
    String? name,
    String? description,
    String? note,
    List<String>? image,
    List<ComboDTO>? combos,
    double? value,
  }) {
    return ProductDTO(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      emphasis: emphasis ?? this.emphasis,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      note: note ?? this.note,
      image: image ?? this.image,
      combos: combos ?? this.combos,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'status': status,
      'emphasis': emphasis,
      'restaurant_id': restaurantId,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'note': note,
      'image': image,
      'combos': combos
          .map((x) => <String, dynamic>{
                'name': x.name,
                'value': x.value,
                'isSelected': x.isSelected,
              })
          .toList(),
      'value': value,
    };
  }

  factory ProductDTO.fromJson(Map<String, dynamic> map) {
    return ProductDTO(
      id: map['id'] != null ? map['id'] as String : null,
      status: map['status'] as bool,
      emphasis: map['emphasis'] as bool,
      quantity: map['quantity'] != null
          ? int.parse(map['quantity'].toString())
          : null,
      restaurantId: map['restaurant_id'] as String,
      categoryId: map['category_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      note: map['note'] != null ? map['note'] as String : null,
      image: List<String>.from((map['image'])),
      combos: map['combos'] != null && (map['combos'] as List).isNotEmpty
          ? (map['combos'] as List)
              .map((combo) => ComboDTO.fromJson(combo))
              .toList()
          : [],
      value: map['value'] as double,
    );
  }

  @override
  bool operator ==(covariant ProductDTO other) {
    if (identical(this, other)) return true;

    return other.statusOrder == statusOrder && other.orderId == orderId;
  }

  @override
  int get hashCode => statusOrder.hashCode ^ orderId.hashCode;
}
