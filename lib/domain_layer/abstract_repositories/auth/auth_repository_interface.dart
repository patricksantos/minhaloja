import 'package:quickfood/domain_layer/entities.dart';

import 'package:quickfood/data_layer/data_layer.dart';

import 'package:quickfood/infra/infra.dart';

abstract class AuthRepositoryInterface {
  Future<Result<void>> createUser({
    required UserDTO user,
  });

  Future<Result<UserDTO>> getUser({
    required String authToken,
  });

  Future<Result<UserAddressByZipCodeEntity>> consultAddress({
    required String zipCode,
  });
}
