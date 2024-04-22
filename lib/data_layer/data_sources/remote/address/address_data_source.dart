import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import '../../../data_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class AddressDataSource {
  final FirebaseFirestore _firebase;
  late Dio http;

  AddressDataSource({
    required FirebaseFirestore firebase,
  }) : _firebase = firebase {
    http = Dio();
  }

  Future<Result<AddressDTO?>> getAddress({
    required String userId,
  }) async {
    try {
      AddressDTO? addressDTO;
      final addressRef = _firebase.collection(DBCollections.address);
      final userAddressRef = _firebase.collection(DBCollections.userAddress);

      await userAddressRef
          .where('user_id', isEqualTo: userId)
          .snapshots()
          .first
          .then(
        (value) async {
          final userAddressDTO =
              UserAddressDTO.fromJson(value.docs.first.data());
          final address = await addressRef
              .where('id', isEqualTo: userAddressDTO.addressId)
              .snapshots()
              .first;

          addressDTO = AddressDTO.fromJson(address.docs.first.data());
        },
      );

      return Result.success(addressDTO);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<void>> createAddress({
    required String userId,
    required AddressDTO address,
  }) async {
    try {
      final addressRef = _firebase.collection(DBCollections.address);
      final userAddressRef = _firebase.collection(DBCollections.userAddress);

      await addressRef
          .doc(address.id)
          .set(address.toJson())
          .catchError((error) => Result.error(FailureError(error)))
          .then(
        (value) async {
          final userAddressDTO = UserAddressDTO(
            userId: userId,
            addressId: address.id!,
          );

          await userAddressRef
              .doc(userAddressDTO.id)
              .set(userAddressDTO.toJson())
              .catchError((error) => Result.error(FailureError(error)));
        },
      );

      return Result.success(null);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<void>> updateAddress({
    required String addressId,
    required AddressDTO address,
  }) async {
    try {
      final addressRef = _firebase.collection(DBCollections.address);
      address.id = addressId;
      await addressRef
          .doc(addressId)
          .update(address.toJson())
          .catchError((error) => Result.error(FailureError(error)));

      return Result.success(null);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<UserAddressByZipCodeResponseDTO?>> consultAddress({
    required String zipCode,
  }) async {
    try {
      return http.get(TBEndpoints.addressByZipCode(zipCode)).result(
        (value) {
          final isError = value['erro'] == 'true';
          UserAddressByZipCodeResponseDTO? addressByZipCode =
              !isError ? UserAddressByZipCodeResponseDTO.fromJson(value) : null;
          return addressByZipCode;
        },
      );
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
