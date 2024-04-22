import 'package:quickfood/infra/infra.dart';
import 'package:quickfood/data_layer/data_layer.dart';

abstract class ProductRepositoryInterface {
  Future<Result<void>> createProduct({
    required ProductDTO product,
  });

  Future<Result<List<ProductDTO>>> getProduct({
    required String restaurantId,
  });
}
