import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/data_layer/data_layer.dart';

abstract class RestaurantRepositoryInterface {
  Future<Result<void>> createRestaurant({
    required RestaurantRequestDTO restaurant,
  });

  Future<Result<void>> updateRestaurant({
    required RestaurantRequestDTO restaurant,
  });

  Future<Result<RestaurantDTO>> getRestaurant({
    required String? name,
    required String? userId,
  });
}
