import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class GetProductByIdUseCase {
  final ProductRepositoryInterface _repository;

  GetProductByIdUseCase({
    required ProductRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<ProductDTO>> call({
    required String productId,
  }) async {
    return await _repository.getProductById(
      productId: productId,
    );
  }
}
