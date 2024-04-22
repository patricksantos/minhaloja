enum StoreType {
  none,
  delivery,
  menu;

  bool isDelivery() => this == StoreType.delivery;
  bool isMenu() => this == StoreType.menu;
}
