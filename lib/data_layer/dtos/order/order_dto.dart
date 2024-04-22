import 'package:uuid/uuid.dart';

import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';
import 'package:quickfood/infra/infra.dart';

class OrderProductDTO extends OrderProductEntity {
  OrderProductDTO({
    super.id,
    super.status,
    required super.orderId,
    required super.productId,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
    status = status ?? StatusOrder.confirmado;
  }

  OrderProductDTO copyWith({
    String? id,
    String? orderId,
    String? productId,
    StatusOrder? status,
  }) {
    return OrderProductDTO(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'status': status.toString().split('.')[1],
    };
  }

  factory OrderProductDTO.fromJson(Map<String, dynamic> map) {
    return OrderProductDTO(
      id: map['id'] != null ? map['id'] as String : null,
      orderId: map['order_id'] as String,
      productId: map['product_id'] as String,
      status: map['status'] == 'emPreparo'
          ? StatusOrder.emPreparo
          : map['status'] == 'pronto'
              ? StatusOrder.pronto
              : map['status'] == 'confirmado'
                  ? StatusOrder.confirmado
                  : map['status'] == 'aCaminho'
                      ? StatusOrder.aCaminho
                      : StatusOrder.none,
    );
  }
}

class OrderDTO extends OrderEntity {
  List<ProductDTO> products = [];

  OrderDTO({
    super.id,
    super.couponId,
    super.paidOut,
    super.addressId,
    required super.userId,
    required super.restaurantId,
    required super.paymentId,
    required super.productsId,
    required super.totalValue,
    required super.storeType,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'restaurant_id': restaurantId,
      'payment_id': paymentId,
      'user_id': userId,
      'coupon_id': couponId,
      'products_id': productsId,
      'total_value': totalValue,
      'store_type': storeType.toString().split('.')[1],
      'paid_out': paidOut,
      'created_at': DateTime.now(),
    };
  }

  factory OrderDTO.fromJson(Map<String, dynamic> map) {
    return OrderDTO(
      id: map['id'] != null ? map['id'] as String : null,
      restaurantId: map['restaurant_id'] as String,
      paymentId: map['payment_id'] as String,
      userId: map['user_id'] as String,
      couponId: map['coupon_id'] != null ? map['coupon_id'] as int : null,
      productsId: List<String>.from(map['products_id']),
      totalValue: map['total_value'] as double,
      paidOut: map['paid_out'] as bool,
      storeType: map['store_type'] == 'delivery'
          ? StoreType.delivery
          : map['store_type'] == 'menu'
              ? StoreType.menu
              : StoreType.none,
    );
  }
}
