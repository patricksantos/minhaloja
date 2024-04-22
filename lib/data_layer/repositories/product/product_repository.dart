import 'package:quickfood/infra/infra.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';
import '../../data_layer.dart';

class ProductRepository implements ProductRepositoryInterface {
  final ProductDataSource _dataSource;

  ProductRepository({
    required ProductDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Result<void>> createProduct({
    required ProductDTO product,
  }) async {
    return await _dataSource.createProduct(
      product: product,
    );
  }

  @override
  Future<Result<List<ProductDTO>>> getProduct({
    required String restaurantId,
  }) async {
    return await _dataSource.getProduct(
      restaurantId: restaurantId,
    );
  }
}
