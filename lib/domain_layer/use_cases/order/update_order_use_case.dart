import '../../domain_layer.dart';
import 'package:minhaloja/infra/infra.dart';

class UpdateOrderUseCase {
  final OrderRepositoryInterface _repository;

  UpdateOrderUseCase({
    required OrderRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<void>> call({
    required String orderId,
    bool? paidOut,
    StatusOrder? status,
    StoreType? storeType,
  }) async {
    return await _repository.updateOrder(
      orderId: orderId,
      paidOut: paidOut,
      status: status,
      storeType: storeType,
    );
  }
}
