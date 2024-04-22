import 'package:quickfood/domain_layer/domain_layer.dart';
import 'package:quickfood/data_layer/data_layer.dart';

import 'package:quickfood/infra/infra.dart';

class AddressRepository implements AddressRepositoryInterface {
  final AddressDataSource _dataSource;

  AddressRepository({
    required AddressDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Result<AddressDTO?>> getAddress({
    required String userId,
  }) {
    return _dataSource.getAddress(userId: userId);
  }

  @override
  Future<Result<UserAddressByZipCodeEntity?>> consultAddress({
    required String zipCode,
  }) {
    return _dataSource.consultAddress(zipCode: zipCode);
  }

  @override
  Future<Result<void>> createAddress({
    required String userId,
    required AddressDTO address,
  }) {
    return _dataSource.createAddress(
      userId: userId,
      address: address,
    );
  }

  @override
  Future<Result<void>> updateAddress({
    required String addressId,
    required AddressDTO address,
  }) {
    return _dataSource.updateAddress(
      addressId: addressId,
      address: address,
    );
  }
}
