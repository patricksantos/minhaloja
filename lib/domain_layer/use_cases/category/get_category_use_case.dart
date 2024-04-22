import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class GetCategoryUseCase {
  final CategoryRepositoryInterface _repository;

  GetCategoryUseCase({
    required CategoryRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<List<CategoryDTO>>> call({
    required String restaurantId,
  }) async {
    return await _repository.getCategory(
      restaurantId: restaurantId,
    );
  }
}
