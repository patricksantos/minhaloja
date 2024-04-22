import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';
import '../../data_layer.dart';

class CategoryRepository implements CategoryRepositoryInterface {
  final CategoryDataSource _dataSource;

  CategoryRepository({
    required CategoryDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Result<void>> createCategory({
    required CategoryDTO category,
  }) async {
    return await _dataSource.createCategory(
      category: category,
    );
  }

  @override
  Future<Result<List<CategoryDTO>>> getCategory({
    required String restaurantId,
  }) async {
    return await _dataSource.getCategory(
      restaurantId: restaurantId,
    );
  }
}
