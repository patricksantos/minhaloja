import 'package:quickfood/infra/infra.dart';
import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class GetRestaurantUseCase {
  final RestaurantRepositoryInterface _repository;

  GetRestaurantUseCase({
    required RestaurantRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<RestaurantDTO>> call({
    String? name,
    String? userId,
  }) async {
    return await _repository.getRestaurant(
      name: name,
      userId: userId,
    );
  }
}
