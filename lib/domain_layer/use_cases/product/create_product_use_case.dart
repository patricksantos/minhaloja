import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

import 'package:quickfood/infra/infra.dart';

class CreateProductUseCase {
  final ProductRepositoryInterface _repository;

  CreateProductUseCase({
    required ProductRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<void>> call({
    required ProductDTO product,
  }) async {
    return await _repository.createProduct(
      product: product,
    );
  }
}
