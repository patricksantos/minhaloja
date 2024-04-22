import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';

import 'cubit/order_cubit.dart';
import 'order_page.dart';

class OrderModule extends WidgetModule {
  final bool isExpanded;

  OrderModule({
    super.key,
    required this.isExpanded,
  });

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
  Widget get view => OrderPage(isExpanded: isExpanded);
}
