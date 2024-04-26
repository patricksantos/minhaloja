class PageRoutes {
  /// [QrCode]
  static const qrcode = '/';

  /// [Home]
  static const home = '/';

  /// [Pedidos]
  static const order = '/pedidos/';

  /// [Carrinho]
  static const cartProducts = '/carrinho/';

  /// [ProductDetails]
  // static const productDetails = '/produto/';
  static String productDetails(String id) => '/produto/$id';

  /// [Dashboard]
  static const dashboard = '/dashboard/';

  /// [Login]
  static const login = '/login/';
}
