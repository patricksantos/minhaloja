enum StorageType {
  product,
  store;

  @override
  String toString() => this == StorageType.product
      ? 'images/product'
      : this == StorageType.store
          ? 'images/store'
          : 'images';
}
