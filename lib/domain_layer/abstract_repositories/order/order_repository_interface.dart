import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/infra/infra.dart';

abstract class OrderRepositoryInterface {
  Future<Result<void>> createOrder({
    required OrderDTO order,
  });

  Future<Result<List<OrderDTO>?>> getOrder({
    required String userId,
    required String storeType,
  });
}
