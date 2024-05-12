import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class GetRestaurantUseCase {
  final RestaurantRepositoryInterface _repository;

  GetRestaurantUseCase({
    required RestaurantRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<RestaurantDTO>> call() async {
    return await _repository.getRestaurant();
  }
}
