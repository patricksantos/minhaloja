// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/data_layer/dtos/combo/combo_dto.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

class ProductListCartDTO extends ProductListCart {
  // ignore: annotate_overrides, overridden_fields
  final List<ProductDTO> products;
  String order = '';
  ProductListCartDTO({
    super.id,
    super.quantity = 0,
    required super.productId,
    required super.restaurantId,
    required super.combo,
    required this.products,
  }) : super(products: products) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }

  ProductListCartDTO copyWith({
    String? id,
    int? quantity,
    String? productId,
    String? restaurantId,
    ComboDTO? combo,
    List<ProductDTO>? products,
  }) {
    return ProductListCartDTO(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
      restaurantId: restaurantId ?? this.restaurantId,
      combo: combo ?? this.combo,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'productId': productId,
      'restaurantId': restaurantId,
      // 'combo': combo != null ? (combo as ComboDTO).toJson() : null,
      'combo': combo != null
          ? <String, dynamic>{
              'name': combo?.name,
              'value': combo?.value,
              'isSelected': combo?.isSelected,
            }
          : null,
      'products': products.map((x) => (x).toJson()).toList(),
    };
  }

  factory ProductListCartDTO.fromJson(Map<String, dynamic> map) {
    return ProductListCartDTO(
      id: map['id'] != null ? map['id'] as String : null,
      quantity: map['quantity'] as int,
      productId: map['productId'] as String,
      restaurantId: map['restaurantId'] as String,
      combo: map['combo'] != null
          ? ComboDTO(name: map['combo']['name'], value: map['combo']['value'])
          : null,
      products: List<ProductDTO>.from(
        (map['products'] as List<dynamic>).map<ProductDTO>(
          (x) => ProductDTO.fromJson(x),
        ),
      ),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory ProductListCartDTO.fromJson(String source) =>
  //     ProductListCartDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ProductListCartDTO other) {
    if (identical(this, other)) return true;

    return listEquals(other.products, products) && other.order == order;
  }

  @override
  int get hashCode => products.hashCode ^ order.hashCode;
}
