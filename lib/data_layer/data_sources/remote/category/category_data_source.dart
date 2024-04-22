import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:quickfood/infra/infra.dart';
import '../../../data_layer.dart';

class CategoryDataSource {
  final FirebaseFirestore _firebase;

  CategoryDataSource({
    required FirebaseFirestore firebase,
  }) : _firebase = firebase;

  Future<Result<void>> createCategory({
    required CategoryDTO category,
  }) async {
    try {
      final categoryRef = _firebase.collection(DBCollections.category);
      await categoryRef.doc(category.id).set(category.toJson()).catchError(
            (error) => Result.error(FailureError(error)),
          );

      return Result.success(null);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<List<CategoryDTO>>> getCategory({
    required String restaurantId,
  }) async {
    try {
      final categoryRef = _firebase.collection(DBCollections.category);
      final category = categoryRef
          .where('restaurant_id', isEqualTo: restaurantId)
          .snapshots();

      List<CategoryDTO> categories = await category.map((element) {
        return element.docs.map(
          (category) {
            return CategoryDTO.fromJson(category.data());
          },
        ).toList();
      }).first;

      return Result.success(categories);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
