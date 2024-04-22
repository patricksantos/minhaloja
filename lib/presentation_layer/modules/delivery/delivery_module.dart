import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/delivery_cubit.dart';
import 'delivery_page.dart';

class DeliveryModule extends WidgetModule {
  final double totalValue;
  DeliveryModule({
    super.key,
    required this.totalValue,
  });

  @override
  List<Bind> get binds => [
        // DataSource

        // Repository

        // Use Cases

        // Cubit
        Bind.lazySingleton((i) => DeliveryCubit())
      ];

  @override
  Widget get view => DeliveryPage(totalValue: totalValue);
}
