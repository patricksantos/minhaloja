import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:uuid/uuid.dart';

class RestaurantEntity {
  String? id;
  UserEntity? user;
  AddressEntity? address;
  String url;
  String? userId;
  final String? addressId;
  final String logoUrl;
  final String backgroundUrl;
  final String name;
  final String segment;
  final String cnpj;
  final String phoneNumber;
  final String description;
  List<BannerEntity>? banner;

  RestaurantEntity({
    this.id,
    this.user,
    this.address,
    this.addressId,
    this.userId,
    required this.logoUrl,
    required this.backgroundUrl,
    required this.url,
    required this.name,
    required this.segment,
    required this.cnpj,
    required this.phoneNumber,
    required this.description,
    this.banner,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
    url = url.replaceAll(' ', '-');
  }
}
