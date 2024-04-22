import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:minhaloja/infra/infra.dart';
import '../../../data_layer.dart';

class FormPaymentDataSource {
  final FirebaseFirestore _firebase;

  FormPaymentDataSource({
    required FirebaseFirestore firebase,
  }) : _firebase = firebase;

  Future<Result<List<FormPaymentDTO>?>> getFormPayment() async {
    try {
      final formPaymentRef = _firebase.collection(DBCollections.formPayment);

      // final request = formPaymentRef.orderBy('name').snapshots();
      // var listFormPayment = await request.map((element) {
      //   return element.docs
      //       .map((order) => FormPaymentDTO.fromJson(order.data()))
      //       .toList();
      // }).first;

      final listFormPayment = await formPaymentRef.orderBy('name').get().then(
        (data) {
          if (data.docs.isEmpty) {
            return [] as List<FormPaymentDTO>;
          }
          return data.docs
              .map((doc) => FormPaymentDTO.fromJson(doc.data()))
              .toList();
        },
      );

      if (listFormPayment.isNotEmpty) {
        return Result.success(listFormPayment);
      } else {
        return Result.success(null);
      }
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
