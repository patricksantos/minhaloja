import 'package:uuid/uuid.dart';

import 'package:minhaloja/infra/infra.dart';

class OrderProductEntity {
  String? id;
  StatusOrder? status;
  final String orderId;
  final String productId;

  OrderProductEntity({
    this.id,
    required this.status,
    required this.orderId,
    required this.productId,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
    status = status ?? StatusOrder.confirmado;
  }
}

class OrderEntity {
  String? id;
  String? addressId;
  final String restaurantId;
  final String paymentId;
  final String userId;
  final String userCPF;
  final int? couponId;
  final List<String> productsId;
  final double totalValue;
  final StoreType storeType;
  final DateTime? createdAt;
  bool? paidOut;

  OrderEntity({
    this.id,
    this.couponId,
    this.paidOut,
    this.addressId,
    this.createdAt,
    required this.userId,
    required this.userCPF,
    required this.restaurantId,
    required this.paymentId,
    required this.productsId,
    required this.totalValue,
    required this.storeType,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
    paidOut = paidOut ?? false;
  }

  OrderEntity copyWith({
    String? restaurantId,
    String? paymentId,
    String? userCPF,
    String? userId,
    int? couponId,
    List<String>? productsId,
    double? totalValue,
    StoreType? storeType,
    String? addressId,
    bool? paidOut,
  }) {
    var uuid = const Uuid();
    return OrderEntity(
      id: uuid.v4(),
      restaurantId: restaurantId ?? this.restaurantId,
      paymentId: paymentId ?? this.paymentId,
      userCPF: userCPF ?? this.userCPF,
      userId: userId ?? this.userId,
      couponId: couponId ?? this.couponId,
      productsId: productsId ?? this.productsId,
      totalValue: totalValue ?? this.totalValue,
      paidOut: paidOut ?? this.paidOut,
      storeType: storeType ?? this.storeType,
      addressId: addressId ?? this.addressId,
    );
  }
}
