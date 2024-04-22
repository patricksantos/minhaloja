import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/data_layer/data_layer.dart';

abstract class CategoryRepositoryInterface {
  Future<Result<void>> createCategory({
    required CategoryDTO category,
  });

  Future<Result<List<CategoryDTO>>> getCategory({
    required String restaurantId,
  });
}
