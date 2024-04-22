import 'package:quickfood/infra/infra.dart';
import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class CreateOrderUseCase {
  final OrderRepositoryInterface _repository;

  CreateOrderUseCase({
    required OrderRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<void>> call({
    required OrderDTO order,
  }) async {
    return await _repository.createOrder(
      order: order,
    );
  }
}
