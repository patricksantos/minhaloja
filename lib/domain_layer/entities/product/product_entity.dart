import 'package:uuid/uuid.dart';

class ProductEntity {
  String? id;
  int? quantity;
  bool status;
  bool emphasis;
  final String restaurantId;
  final String categoryId;
  final String name;
  final String description;
  final String? note;
  final List<String> image;
  final double value;

  ProductEntity({
    this.id,
    this.quantity,
    this.note,
    this.status = true,
    this.emphasis = false,
    required this.restaurantId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.image,
    required this.value,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }
}
