import '../../domain_layer.dart';

import 'package:quickfood/infra/infra.dart';

class GetAddressByZipCodeUseCase {
  final AddressRepositoryInterface _repository;

  GetAddressByZipCodeUseCase({
    required AddressRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<UserAddressByZipCodeEntity?>> call({
    required String zipCode,
  }) {
    return _repository.consultAddress(zipCode: zipCode);
  }
}
