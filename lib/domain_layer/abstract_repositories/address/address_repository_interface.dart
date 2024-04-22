import 'package:quickfood/domain_layer/domain_layer.dart';
import 'package:quickfood/data_layer/data_layer.dart';

import 'package:quickfood/infra/infra.dart';

abstract class AddressRepositoryInterface {
  Future<Result<AddressDTO?>> getAddress({
    required String userId,
  });

  Future<Result<UserAddressByZipCodeEntity?>> consultAddress({
    required String zipCode,
  });

  Future<Result<void>> updateAddress({
    required String addressId,
    required AddressDTO address,
  });

  Future<Result<void>> createAddress({
    required String userId,
    required AddressDTO address,
  });
}
