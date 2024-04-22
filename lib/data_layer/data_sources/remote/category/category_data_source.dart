import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:minhaloja/infra/infra.dart';
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
      // final category = categoryRef
      //     .where('restaurant_id', isEqualTo: 1.toString())
      //     .snapshots();

      // List<CategoryDTO> categories = await category.map((element) {
      //   return element.docs.map(
      //     (category) {
      //       return CategoryDTO.fromJson(category.data());
      //     },
      //   ).toList();
      // }).first;

      final categories = await categoryRef
          .where('restaurant_id', isEqualTo: 1.toString())
          .get()
          .then(
        (data) {
          if (data.docs.isEmpty) {
            return [] as List<CategoryDTO>;
          }
          return data.docs
              .map((doc) => CategoryDTO.fromJson(doc.data()))
              .toList();
        },
      );

      return Result.success(categories);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
