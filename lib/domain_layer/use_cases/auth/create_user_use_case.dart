import 'package:quickfood/infra/infra.dart';
import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class CreateUserUseCase {
  final AuthRepositoryInterface _repository;

  CreateUserUseCase({
    required AuthRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<void>> call({
    required UserDTO user,
  }) async {
    return await _repository.createUser(user: user);
  }
}
