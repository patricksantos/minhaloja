import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:minhaloja/infra/infra.dart';
import '../../../data_layer.dart';

class RestaurantDataSource {
  final FirebaseFirestore _firebase;

  RestaurantDataSource({
    required FirebaseFirestore firebase,
  }) : _firebase = firebase;

  Future<Result<void>> createRestaurant({
    required RestaurantRequestDTO restaurant,
  }) async {
    try {
      final restaurantRef = _firebase.collection(DBCollections.restaurant);
      final addressRef = _firebase.collection(DBCollections.address);
      final userAddressRef = _firebase.collection(DBCollections.userAddress);

      await restaurantRef.doc(restaurant.id).set(restaurant.toJson()).then(
        (value) async {
          await addressRef
              .doc(restaurant.address!.id)
              .set((restaurant.address! as AddressDTO).toJson())
              .catchError((error) => Result.error(FailureError(error)));

          final userAddressDTO = UserAddressDTO(
            userId: restaurant.userId,
            addressId: restaurant.address!.id!,
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

  Future<Result<void>> updateRestaurant({
    required RestaurantRequestDTO restaurant,
  }) async {
    try {
      final restaurantRef = _firebase.collection(DBCollections.restaurant);
      final addressRef = _firebase.collection(DBCollections.address);

      await restaurantRef.doc(restaurant.id).update(restaurant.toJson()).then(
        (value) async {
          await addressRef
              .doc(restaurant.address!.id)
              .update((restaurant.address! as AddressDTO).toJson())
              .catchError((error) => Result.error(FailureError(error)));
        },
      );

      return Result.success(null);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<RestaurantDTO>> getRestaurant({
    String? name,
    String? userId,
  }) async {
    try {
      RestaurantDTO? restaurantDTO;
      AddressDTO? addressDTO;
      final addressRef = _firebase.collection(DBCollections.address);
      final restaurantRef = _firebase.collection(DBCollections.restaurant);

      QuerySnapshot<Map<String, dynamic>>? restaurant;
      if (userId != null) {
        restaurant = await restaurantRef
            .where('user_id', isEqualTo: userId)
            .snapshots()
            .first;

        restaurantDTO = RestaurantDTO.fromJson(restaurant.docs.first.data());
        final address = await addressRef
            .where('id', isEqualTo: restaurantDTO.addressId)
            .snapshots()
            .first;

        addressDTO = AddressDTO.fromJson(address.docs.first.data());
        restaurantDTO.address = addressDTO;
      } else {
        final restaurant =
            await restaurantRef.where('id', isEqualTo: '1').get();
        restaurantDTO = RestaurantDTO.fromJson(restaurant.docs.first.data());
      }

      return Result.success(
        RestaurantDTO(
          id: restaurantDTO.id,
          backgroundUrl: restaurantDTO.backgroundUrl,
          cnpj: restaurantDTO.cnpj,
          description: restaurantDTO.description,
          logoUrl: restaurantDTO.logoUrl,
          name: restaurantDTO.name,
          phoneNumber: restaurantDTO.phoneNumber,
          segment: restaurantDTO.segment,
          url: restaurantDTO.url,
          userId: restaurantDTO.userId,
          addressId: restaurantDTO.addressId,
          user: restaurantDTO.user,
          address: addressDTO,
        ),
      );
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
