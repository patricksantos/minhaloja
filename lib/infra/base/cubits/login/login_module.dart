import 'package:flutter_modular/flutter_modular.dart';

import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';

import './login_cubit.dart';

abstract class LoginModule {
  static List<Bind> get binds => [
        // DataSource
        Bind.lazySingleton((i) => AuthDataSource(firebase: i())),

        // Repository
        Bind.lazySingleton((i) => AuthRepository(dataSource: i())),

        // User Cases
        Bind.lazySingleton((i) => CreateUserUseCase(repository: i())),

        // Cubit
        Bind.lazySingleton((i) => LoginCubit(i(), i())),
      ];
}
