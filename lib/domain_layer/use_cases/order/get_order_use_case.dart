import 'package:minhaloja/data_layer/data_layer.dart';
import '../../domain_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class GetOrderUseCase {
  final OrderRepositoryInterface _repository;

  GetOrderUseCase({
    required OrderRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<List<OrderDTO>?>> call({
    required String userId,
    required String storeType,
  }) async {
    return await _repository.getOrder(
      userId: userId,
      storeType: storeType,
    );
  }
}
