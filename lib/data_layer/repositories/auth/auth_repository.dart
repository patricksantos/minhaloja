import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';
import '../../data_layer.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AuthDataSource _dataSource;

  AuthRepository({
    required AuthDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Result<void>> createUser({
    required UserDTO user,
  }) async {
    return await _dataSource.createUser(user: user);
  }

  @override
  Future<Result<UserDTO>> getUser({
    required String authToken,
  }) async {
    return await _dataSource.getUser(
      authToken: authToken,
    );
  }

  @override
  Future<Result<UserAddressByZipCodeEntity>> consultAddress({
    required String zipCode,
  }) {
    return _dataSource.consultAddress(zipCode: zipCode);
  }
}
