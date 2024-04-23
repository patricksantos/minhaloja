import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/data_layer/data_layer.dart';

abstract class ProductRepositoryInterface {
  Future<Result<void>> createProduct({
    required ProductDTO product,
  });

  Future<Result<List<ProductDTO>>> getProduct({
    required String restaurantId,
  });

  Future<Result<ProductDTO>> getProductById({
    required String productId,
  });
}
