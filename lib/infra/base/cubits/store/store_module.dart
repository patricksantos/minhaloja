import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/infra/base/cubits/store/store_cubit.dart';

import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/data_layer/data_layer.dart';

import '../../../infra.dart';

abstract class StoreModule {
  static List<Bind> get binds => [
        // DataSource
        Bind.lazySingleton((i) => FormPaymentDataSource(firebase: i())),

        // Repository
        Bind.lazySingleton((i) => FormPaymentRepository(dataSource: i())),

        // Use Cases
        Bind.lazySingleton((i) => GetFormPaymentUseCase(repository: i())),

        // Cubit
        Bind.lazySingleton((i) => StoreCubit(i())),
      ];
}
