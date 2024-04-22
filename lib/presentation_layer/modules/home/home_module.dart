import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/infra/responsive/responsive_screen.dart';
import 'package:minhaloja/infra/utils.dart';

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

  // store: args.params['store'] ?? '',,
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) {
        if (ResponsiveScreen.isDesktop(context)) {
          final design = DesignSystem.of(context);
          return Scaffold(
            backgroundColor: design.primary100,
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Para comprar Acesse o Site no seu Celular! ',
                      style: design
                          .h3(color: design.gray)
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const HomePage();
      },
    ),
  ];
}
