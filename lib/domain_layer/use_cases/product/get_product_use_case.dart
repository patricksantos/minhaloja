import 'package:quickfood/infra/infra.dart';
import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class GetProductUseCase {
  final ProductRepositoryInterface _repository;

  GetProductUseCase({
    required ProductRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<List<ProductDTO>>> call({
    required String restaurantId,
  }) async {
    return await _repository.getProduct(
      restaurantId: restaurantId,
    );
  }
}
