import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:minhaloja/infra/infra.dart';
import '../../../data_layer.dart';

class AuthDataSource {
  final FirebaseFirestore _firebase;
  late Dio http;

  AuthDataSource({
    required FirebaseFirestore firebase,
  }) : _firebase = firebase {
    http = Dio();
  }

  Future<Result<void>> createUser({
    required UserDTO user,
  }) async {
    try {
      final userRef = _firebase.collection(DBCollections.user);
      await userRef.doc(user.id).set(user.toJson()).catchError(
            (error) => Result.error(FailureError(error)),
          );

      return Result.success(null);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<UserAddressByZipCodeResponseDTO>> consultAddress({
    required String zipCode,
  }) async {
    return http
        .get(TBEndpoints.addressByZipCode(zipCode))
        .result(UserAddressByZipCodeResponseDTO.fromJson);
  }

  Future<Result<UserDTO>> getUser({
    required String authToken,
  }) async {
    try {
      final userRef = _firebase.collection(DBCollections.user);
      final user = await userRef
          .where('authToken', isEqualTo: authToken)
          .snapshots()
          .first;

      return Result.success(
        UserDTO.fromJson(user.docs.first.data()),
      );
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
