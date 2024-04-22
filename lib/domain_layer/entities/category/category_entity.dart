import 'package:uuid/uuid.dart';

class CategoryEntity {
  String? id;
  final String restaurantId;
  final String name;

  CategoryEntity({
    this.id,
    required this.restaurantId,
    required this.name,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }
}
