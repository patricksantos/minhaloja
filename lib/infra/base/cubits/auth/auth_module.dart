import 'package:flutter_modular/flutter_modular.dart';
import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';

import 'package:quickfood/infra/infra.dart';

abstract class AuthModule {
  static List<Bind> get binds => [
        // DataSource
        Bind.lazySingleton((i) => AuthDataSource(firebase: i())),
        Bind.lazySingleton((i) => RestaurantDataSource(firebase: i())),
        Bind.lazySingleton((i) => CategoryDataSource(firebase: i())),
        Bind.lazySingleton((i) => ProductDataSource(firebase: i())),
        Bind.lazySingleton((i) => AddressDataSource(firebase: i())),
        Bind.lazySingleton((i) => ImageDataSource(firebase: i())),

        // Repository
        Bind.lazySingleton((i) => AuthRepository(dataSource: i())),
        Bind.lazySingleton((i) => RestaurantRepository(dataSource: i())),
        Bind.lazySingleton((i) => CategoryRepository(dataSource: i())),
        Bind.lazySingleton((i) => ProductRepository(dataSource: i())),
        Bind.lazySingleton((i) => AddressRepository(dataSource: i())),
        Bind.lazySingleton((i) => ImageRepository(dataSource: i())),

        // User Cases
        Bind.lazySingleton((i) => CreateUserUseCase(repository: i())),
        Bind.lazySingleton((i) => CreateRestaurantUseCase(repository: i())),
        Bind.lazySingleton((i) => UpdateRestaurantUseCase(repository: i())),
        Bind.lazySingleton((i) => CreateCategoryUseCase(repository: i())),
        Bind.lazySingleton((i) => CreateProductUseCase(repository: i())),
        Bind.lazySingleton((i) => GetUserUseCase(repository: i())),
        Bind.lazySingleton((i) => GetAddressByZipCodeUseCase(repository: i())),
        Bind.lazySingleton((i) => GetAddressUseCase(repository: i())),
        Bind.lazySingleton((i) => CreateAddressUseCase(repository: i())),
        Bind.lazySingleton((i) => UpdateAddressUseCase(repository: i())),
        Bind.lazySingleton((i) => UploadImageUseCase(repository: i())),

        // Cubit
        Bind.lazySingleton(
          (i) =>
              AuthCubit(i(), i(), i(), i(), i(), i(), i(), i(), i(), i(), i()),
        ),
      ];
}
