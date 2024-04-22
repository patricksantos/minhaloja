import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';

class ProductListCartDTO extends ProductListCart {
  // ignore: annotate_overrides, overridden_fields
  final List<ProductDTO> products;
  String order = '';
  ProductListCartDTO({
    super.id,
    super.quantity = 0,
    required super.productId,
    required super.restaurantId,
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
    List<ProductDTO>? products,
  }) {
    return ProductListCartDTO(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
      restaurantId: restaurantId ?? this.restaurantId,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'productId': productId,
      'restaurantId': restaurantId,
      'products': products.map((x) => (x).toJson()).toList(),
    };
  }

  factory ProductListCartDTO.fromMap(Map<String, dynamic> map) {
    return ProductListCartDTO(
      id: map['id'] != null ? map['id'] as String : null,
      quantity: map['quantity'] as int,
      productId: map['productId'] as String,
      restaurantId: map['restaurantId'] as String,
      products: List<ProductDTO>.from(
        (map['products'] as List<dynamic>).map<ProductDTO>(
          (x) => ProductDTO.fromJson(x),
        ),
      ),
      // products: List<ProductDTO>.from(
      //   (map['products']).map<ProductDTO>(
      //     (x) => ProductDTO.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductListCartDTO.fromJson(String source) =>
      ProductListCartDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
