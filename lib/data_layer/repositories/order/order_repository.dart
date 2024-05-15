import 'package:minhaloja/domain_layer/domain_layer.dart';
import '../../data_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class OrderRepository implements OrderRepositoryInterface {
  final OrderDataSource _dataSource;

  OrderRepository({
    required OrderDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Result<void>> createOrder({
    required OrderDTO order,
  }) async {
    return await _dataSource.createOrder(
      order: order,
    );
  }

  @override
  Future<Result<void>> updateOrder({
    required String orderId,
    bool? paidOut,
    StatusOrder? status,
    StoreType? storeType,
  }) async {
    return await _dataSource.updateOrder(
      orderId: orderId,
      paidOut: paidOut,
      status: status,
      storeType: storeType,
    );
  }

  @override
  Future<Result<List<OrderDTO>?>> getOrder({
    required String userId,
    required String storeType,
  }) async {
    return await _dataSource.getOrder(
      userId: userId,
      storeType: storeType,
    );
  }
}
