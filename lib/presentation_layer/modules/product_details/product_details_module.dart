import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import 'cubit/product_details_cubit.dart';
import 'product_details_page.dart';

class ProductDetailsModule extends Module {
  @override
  final List<Bind> binds = [
    // DataSource
    Bind.lazySingleton((i) => ProductDataSource(firebase: i())),

    // Repository
    Bind.lazySingleton((i) => ProductRepository(dataSource: i())),

    // Use cases
    Bind.lazySingleton((i) => GetProductByIdUseCase(repository: i())),

    Bind.lazySingleton((i) => ProductDetailsCubit(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/:productId',
      child: (context, args) => ProductDetailsPage(
        product: args.data != null ? args.data['product'] : null,
        productId: args.params['productId'],
      ),
    ),
  ];
}
