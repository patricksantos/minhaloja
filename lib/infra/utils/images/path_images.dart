import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PathImages {
  static String pathImage = 'assets/images';
  static String get pizza => '$pathImage/background_pizza.png';
  static String get iconRestaurant => '$pathImage/icon.png';
  static String get image => '$pathImage/image.jpeg';
  static String get refrigerante => '$pathImage/refrigerante.png';
  static String get sorvete => '$pathImage/sorvete.png';

  // Icon
  static String pathIcon = 'assets/icon';
  static String get localizacao => '$pathIcon/localizacao_icon.png';
  static String get restaurant => '$pathIcon/restaurant.png';
  static String get motorbike => '$pathIcon/motorbike.png';
  static String get fastDelivery => '$pathIcon/fast-delivery.png';
  static String get foodDelivery => '$pathIcon/food-delivery.png';
  static String get onlineOrder => '$pathIcon/online-order.png';
  static String get restaurantMenu => '$pathIcon/restaurant-menu.png';
  static String get delivery => '$pathIcon/car-delivery.png';
  static String get frenchFries => '$pathIcon/french-fries.png';

  static SvgPicture shared({
    double? height,
    double? width,
    Color? color,
  }) =>
      SvgPicture.asset(
        '$pathIcon/shared.svg',
        height: height,
        width: width,
        color: color,
      );
}
