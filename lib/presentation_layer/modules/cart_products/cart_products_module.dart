import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/cart_products_cubit.dart';
import 'cart_products_page.dart';

class CartProductsModule extends WidgetModule {
  final String userId;
  final String restaurantId;
  final bool isExpanded;

  CartProductsModule({
    super.key,
    required this.userId,
    required this.restaurantId,
    required this.isExpanded,
  });

  @override
  List<Bind> get binds => [
        // DataSource

        // Repository

        // Use Cases

        // Cubit
        Bind.lazySingleton((i) => CartProductsCubit())
      ];

  @override
  Widget get view => CartProductsPage(
        restaurantId: restaurantId,
        userId: userId,
        isExpanded: isExpanded,
      );
}
