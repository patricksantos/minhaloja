import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

import 'package:quickfood/infra/infra.dart';

class CreateAddressUseCase {
  final AddressRepositoryInterface _repository;

  CreateAddressUseCase({
    required AddressRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<void>> call({
    required String userId,
    required AddressDTO address,
  }) {
    return _repository.createAddress(
      userId: userId,
      address: address,
    );
  }
}
