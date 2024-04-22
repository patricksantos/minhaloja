import 'package:flutter_modular/flutter_modular.dart';

import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/data_layer/data_layer.dart';

import 'package:minhaloja/infra/infra.dart';

abstract class CartModule {
  static List<Bind> get binds => [
        // DataSource
        Bind.lazySingleton((i) => OrderDataSource(firebase: i())),

        // Repository
        Bind.lazySingleton((i) => OrderRepository(dataSource: i())),

        // Use Cases
        Bind.lazySingleton((i) => SaveCartItensUseCase(storage: i())),
        Bind.lazySingleton((i) => GetCartItensUseCase(storage: i())),
        Bind.lazySingleton((i) => GetProductsStorageUseCase(storage: i())),
        Bind.lazySingleton((i) => DeleteCartItensUseCase(storage: i())),
        Bind.lazySingleton((i) => CreateOrderUseCase(repository: i())),

        // Cubit
        Bind.lazySingleton((i) => CartCubit(i(), i(), i(), i(), i())),
      ];
}
