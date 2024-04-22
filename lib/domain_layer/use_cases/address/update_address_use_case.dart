import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

import 'package:quickfood/infra/infra.dart';

class UpdateAddressUseCase {
  final AddressRepositoryInterface _repository;

  UpdateAddressUseCase({
    required AddressRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<void>> call({
    required String addressId,
    required AddressDTO address,
  }) {
    return _repository.updateAddress(
      addressId: addressId,
      address: address,
    );
  }
}
