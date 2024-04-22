import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';
import '../../data_layer.dart';

class RestaurantRepository implements RestaurantRepositoryInterface {
  final RestaurantDataSource _dataSource;

  RestaurantRepository({
    required RestaurantDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Result<void>> createRestaurant({
    required RestaurantRequestDTO restaurant,
  }) async {
    return await _dataSource.createRestaurant(
      restaurant: restaurant,
    );
  }

  @override
  Future<Result<void>> updateRestaurant({
    required RestaurantRequestDTO restaurant,
  }) async {
    return await _dataSource.updateRestaurant(
      restaurant: restaurant,
    );
  }

  @override
  Future<Result<RestaurantDTO>> getRestaurant({
    String? name,
    String? userId,
  }) async {
    return await _dataSource.getRestaurant(
      name: name,
      userId: userId,
    );
  }
}
