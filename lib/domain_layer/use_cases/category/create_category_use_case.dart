import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

import 'package:quickfood/infra/infra.dart';

class CreateCategoryUseCase {
  final CategoryRepositoryInterface _repository;

  CreateCategoryUseCase({
    required CategoryRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<void>> call({
    required CategoryDTO category,
  }) async {
    return await _repository.createCategory(
      category: category,
    );
  }
}
