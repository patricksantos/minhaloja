import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:minhaloja/infra/infra.dart';
import '../../../data_layer.dart';

class OrderDataSource {
  final FirebaseFirestore _firebase;

  OrderDataSource({
    required FirebaseFirestore firebase,
  }) : _firebase = firebase;

  Future<Result<void>> createOrder({
    required OrderDTO order,
  }) async {
    try {
      final orderRef = _firebase.collection(DBCollections.order);

      await orderRef
          .doc(order.id)
          .set(order.toJson())
          .catchError(
            (error) => Result.error(FailureError(error)),
          )
          .then(
        (value) async {
          final orderProductRef =
              _firebase.collection(DBCollections.orderProduct);

          for (var element in order.productsId) {
            final orderProduct = OrderProductDTO(
              productId: element,
              orderId: order.id!,
            );
            await orderProductRef
                .doc(orderProduct.id)
                .set(
                  orderProduct.toJson(),
                )
                .catchError((error) => Result.error(FailureError(error)));
          }
        },
      );

      return Result.success(null);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<List<OrderDTO>?>> getOrder({
    required String userId,
    required String storeType,
  }) async {
    try {
      final productRef = _firebase.collection(DBCollections.product);
      final orderProductRef = _firebase.collection(DBCollections.orderProduct);
      final orderRef = _firebase.collection(DBCollections.order);

      final requestOrder = orderRef
          // .where('user_id', isEqualTo: userId)
          // .where('store_type', isEqualTo: storeType)
          // .where('paid_out', isEqualTo: false)
          .snapshots();

      var listOrder = await requestOrder.map((element) {
        return element.docs
            .map((order) => OrderDTO.fromJson(order.data()))
            .toList();
      }).first;

      List<OrderDTO> list = [];
      for (var order in listOrder) {
        var orderProduct =
            orderProductRef.where('order_id', isEqualTo: order.id).snapshots();

        List<OrderProductDTO> orderProductList = await orderProduct
            .map(
              (element) => element.docs
                  .map((item) => OrderProductDTO.fromJson(item.data()))
                  .toList(),
            )
            .first;

        for (var element in orderProductList) {
          final product = await productRef
              .where('id', isEqualTo: element.productId)
              .snapshots()
              .first;

          var productDTO = ProductDTO.fromJson(
            product.docs.first.data(),
          );
          productDTO.statusOrder = element.status ?? StatusOrder.none;
          productDTO.orderId = order.id ?? '';
          order.products.add(productDTO);
        }
        list.add(order);
      }

      if (listOrder.isNotEmpty) {
        return Result.success(list);
      } else {
        return Result.success(null);
      }
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }

  Future<Result<void>> updateOrder({
    required String orderId,
    bool? paidOut,
    StatusOrder? status,
    StoreType? storeType,
  }) async {
    try {
      final orderRef = _firebase.collection(DBCollections.order);
      await orderRef.doc(orderId).update(
        {
          if (status != null) 'status': status.name,
          if (paidOut != null) 'paid_out': paidOut,
          if (storeType != null) 'store_type': storeType.name,
        },
      ).catchError((error) => Result.error(FailureError(error)));

      return Result.success(null);
    } catch (e) {
      return Result.error(FailureError(e));
    }
  }
}
