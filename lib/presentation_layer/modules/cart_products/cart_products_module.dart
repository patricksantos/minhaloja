import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/cart_products_cubit.dart';
import 'cart_products_page.dart';

class CartProductsModule extends Module {
  @override
  List<Bind> get binds => [
        // DataSource

        // Repository

        // Use Cases

        // Cubit
        Bind.lazySingleton((i) => CartProductsCubit())
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const CartProductsPage(),
    ),
  ];
}
