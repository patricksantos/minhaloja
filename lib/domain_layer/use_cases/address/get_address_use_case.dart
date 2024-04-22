import 'package:minhaloja/data_layer/data_layer.dart';
import '../../domain_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class GetAddressUseCase {
  final AddressRepositoryInterface _repository;

  GetAddressUseCase({
    required AddressRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<AddressDTO?>> call({
    required String userId,
  }) {
    return _repository.getAddress(userId: userId);
  }
}
