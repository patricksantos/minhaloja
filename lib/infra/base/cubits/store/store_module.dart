import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/infra/base/cubits/store/store_cubit.dart';

import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/data_layer/data_layer.dart';

import '../../../infra.dart';

abstract class StoreModule {
  static List<Bind> get binds => [
        // DataSource
        Bind.lazySingleton((i) => FormPaymentDataSource(firebase: i())),
        Bind.lazySingleton((i) => RestaurantDataSource(firebase: i())),
        Bind.lazySingleton((i) => OrderDataSource(firebase: i())),

        // Repository
        Bind.lazySingleton((i) => FormPaymentRepository(dataSource: i())),
        Bind.lazySingleton((i) => RestaurantRepository(dataSource: i())),
        Bind.lazySingleton((i) => OrderRepository(dataSource: i())),

        // Use Cases
        Bind.lazySingleton((i) => GetFormPaymentUseCase(repository: i())),
        Bind.lazySingleton((i) => GetRestaurantUseCase(repository: i())),
        Bind.lazySingleton((i) => GetOrderUseCase(repository: i())),
        Bind.lazySingleton((i) => UpdateOrderUseCase(repository: i())),

        // Cubit
        Bind.lazySingleton((i) => StoreCubit(i(), i(), i(), i())),
      ];
}
