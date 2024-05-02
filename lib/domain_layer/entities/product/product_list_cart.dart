import 'package:uuid/uuid.dart';

import 'package:minhaloja/domain_layer/domain_layer.dart';

class ProductListCart {
  String? id;
  int quantity;
  final String productId;
  final String restaurantId;
  final ComboEntity? combo;
  final List<ProductEntity> products;

  ProductListCart({
    required this.products,
    required this.productId,
    required this.restaurantId,
    required this.combo,
    this.quantity = 0,
    this.id,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }
}
