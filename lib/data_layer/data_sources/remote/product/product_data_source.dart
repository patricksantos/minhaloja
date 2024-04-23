import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:minhaloja/infra/infra.dart';
import '../../../data_layer.dart';

class ProductDataSource {
  final FirebaseFirestore _firebase;

  ProductDataSource({
    required FirebaseFirestore firebase,
  }) : _firebase = firebase;

  Future<Result<void>> createProduct({
    required ProductDTO product,
  }) async {
    try {
      final productRef = _firebase.collection(DBCollections.product);
      await productRef.doc(product.id).set(product.toJson()).catchError(
            (error) => Result.error(FailureError(error)),
          );

      return Result.success(null);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<List<ProductDTO>>> getProduct({
    required String restaurantId,
  }) async {
    try {
      final productRef = _firebase.collection(DBCollections.product);
      final products = await productRef.get().then(
        (data) {
          if (data.docs.isEmpty) {
            return [] as List<ProductDTO>;
          }
          return data.docs
              .map((doc) => ProductDTO.fromJson(doc.data()))
              .toList();
        },
      );

      return Result.success(products);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<ProductDTO>> getProductById({
    required String productId,
  }) async {
    try {
      final productRef = _firebase.collection(DBCollections.product);
      final product =
          await productRef.where('id', isEqualTo: productId).get().then(
        (data) {
          if (data.docs.isEmpty) {
            return [] as List<ProductDTO>;
          }
          return data.docs
              .map((doc) => ProductDTO.fromJson(doc.data()))
              .toList();
        },
      );

      return Result.success(product.first);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
