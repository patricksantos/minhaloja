import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class UpdateRestaurantUseCase {
  final RestaurantRepositoryInterface _repository;

  UpdateRestaurantUseCase({
    required RestaurantRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<void>> call({
    required RestaurantRequestDTO restaurant,
  }) async {
    return await _repository.updateRestaurant(
      restaurant: restaurant,
    );
  }
}
