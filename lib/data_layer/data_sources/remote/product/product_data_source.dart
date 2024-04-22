import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:quickfood/infra/infra.dart';
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
      final product = productRef
          .where('restaurant_id', isEqualTo: restaurantId)
          .snapshots();

      List<ProductDTO> products = await product.map((element) {
        return element.docs.map(
          (category) {
            return ProductDTO.fromJson(category.data());
          },
        ).toList();
      }).first;

      return Result.success(products);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
