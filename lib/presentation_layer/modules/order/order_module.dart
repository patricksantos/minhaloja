import 'package:flutter_modular/flutter_modular.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import 'cubit/order_cubit.dart';
import 'order_page.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [
        // DataSource
        Bind.lazySingleton((i) => OrderDataSource(firebase: i())),

        // Repository
        Bind.lazySingleton((i) => OrderRepository(dataSource: i())),

        // Use Cases
        Bind.lazySingleton((i) => GetOrderUseCase(repository: i())),

        // Cubit
        Bind.lazySingleton((i) => OrderCubit(i()))
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const OrderPage(),
    ),
  ];
}
