import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'cubit/dashboard_cubit.dart';
import 'dashboard_page.dart';

class DashboardModule extends Module {
  @override
  final List<Bind> binds = [
    // DataSource
    Bind.lazySingleton((i) => RestaurantDataSource(firebase: i())),
    Bind.lazySingleton((i) => AuthDataSource(firebase: i())),

    // Repository
    Bind.lazySingleton((i) => RestaurantRepository(dataSource: i())),
    Bind.lazySingleton((i) => AuthRepository(dataSource: i())),

    // User Cases
    Bind.lazySingleton((i) => GetRestaurantUseCase(repository: i())),
    Bind.lazySingleton((i) => GetUserUseCase(repository: i())),

    // Cubit
    Bind.lazySingleton((i) => DashboardCubit(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const DashboardPage(page: 0),
    ),
    // ChildRoute(
    //   'vendas',
    //   child: (context, args) => const DashboardPage(page: 1),
    // ),
    // ChildRoute(
    //   'produtos',
    //   child: (context, args) => const DashboardPage(page: 2),
    // ),
    // ChildRoute(
    //   'configuracoes',
    //   child: (context, args) => const DashboardPage(page: 3),
    // ),
  ];
}
