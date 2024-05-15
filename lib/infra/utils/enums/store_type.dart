enum StoreType {
  none,
  delivery,
  menu;

  bool isDelivery() => this == StoreType.delivery;
  bool isMenu() => this == StoreType.menu;

  static StoreType create(String value) {
    return value == 'delivery'
        ? StoreType.delivery
        : value == 'menu'
            ? StoreType.menu
            : StoreType.none;
  }
}
