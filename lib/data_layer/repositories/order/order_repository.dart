import 'package:quickfood/domain_layer/domain_layer.dart';
import '../../data_layer.dart';

import 'package:quickfood/infra/infra.dart';

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
