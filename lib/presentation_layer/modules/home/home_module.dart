import 'package:flutter_modular/flutter_modular.dart';

import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';

import 'cubit/home_cubit.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    // DataSource
    Bind.lazySingleton((i) => RestaurantDataSource(firebase: i())),
    Bind.lazySingleton((i) => CategoryDataSource(firebase: i())),
    Bind.lazySingleton((i) => ProductDataSource(firebase: i())),

    // Repository
    Bind.lazySingleton((i) => RestaurantRepository(dataSource: i())),
    Bind.lazySingleton((i) => CategoryRepository(dataSource: i())),
    Bind.lazySingleton((i) => ProductRepository(dataSource: i())),

    // Use cases
    Bind.lazySingleton((i) => GetRestaurantUseCase(repository: i())),
    Bind.lazySingleton((i) => GetCategoryUseCase(repository: i())),
    Bind.lazySingleton((i) => GetProductUseCase(repository: i())),

    // Cubit
    Bind.lazySingleton((i) => HomeCubit(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/:store',
      child: (context, args) => HomePage(
        store: args.params['store'] ?? '',
      ),
    ),
  ];
}
