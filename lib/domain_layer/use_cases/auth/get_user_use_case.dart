import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class GetUserUseCase {
  final AuthRepositoryInterface _repository;

  GetUserUseCase({
    required AuthRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<UserDTO>> call({
    required String authToken,
  }) async {
    return await _repository.getUser(
      authToken: authToken,
    );
  }
}
