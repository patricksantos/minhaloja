import 'package:quickfood/infra/infra.dart';
import 'package:quickfood/data_layer/data_layer.dart';

abstract class CategoryRepositoryInterface {
  Future<Result<void>> createCategory({
    required CategoryDTO category,
  });

  Future<Result<List<CategoryDTO>>> getCategory({
    required String restaurantId,
  });
}
