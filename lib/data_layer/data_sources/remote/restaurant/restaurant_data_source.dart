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

      await restaurantRef.doc(Restaurant.id).set(restaurant.toJson()).then(
        (value) async {
          await addressRef
              .doc(Restaurant.addressId)
              .set((restaurant.address! as AddressDTO).toJson())
              .catchError((error) => Result.error(FailureError(error)));

          final userAddressDTO = UserAddressDTO(
            userId: restaurant.userId ?? '',
            addressId: Restaurant.addressId!,
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
      await restaurantRef
          .doc(Restaurant.id)
          .update(restaurant.toUpdate())
          .catchError((error) => Result.error(FailureError(error)));
      await addressRef
          .doc(Restaurant.addressId)
          .update((restaurant.address as AddressDTO).toJson())
          .catchError((error) => Result.error(FailureError(error)));

      return Result.success(null);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<RestaurantDTO>> getRestaurant() async {
    try {
      RestaurantDTO? restaurantDTO;
      AddressDTO? addressDTO;
      final addressRef = _firebase.collection(DBCollections.address);
      final bannerRef = _firebase.collection(DBCollections.banner);
      final restaurantRef = _firebase.collection(DBCollections.restaurant);

      final restaurant =
          await restaurantRef.where('id', isEqualTo: Restaurant.id).get();

      restaurantDTO = RestaurantDTO.fromJson(restaurant.docs.first.data());
      final address = await addressRef
          .where('id', isEqualTo: restaurantDTO.addressId)
          .get();

      final banner = await bannerRef.get().then(
        (data) {
          if (data.docs.isEmpty) {
            return [] as List<BannerDTO>;
          }
          return data.docs
              .map((doc) => BannerDTO.fromJson(doc.data()))
              .toList();
        },
      );

      addressDTO = AddressDTO.fromJson(address.docs.first.data());
      restaurantDTO.address = addressDTO;

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
          banner: banner,
        ),
      );
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
