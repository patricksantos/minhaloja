import 'dart:convert';

import 'package:minhaloja/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class SaveCartItensUseCase {
  final StorageRepositoryInterface _storage;

  SaveCartItensUseCase({
    required StorageDataSource storage,
  }) : _storage = storage;

  Future<void> call({
    required List<ProductListCartDTO> productListCart,
    required List<ProductDTO> products,
  }) async {
    await _storage.setStorageListData(
      StorageKeys.cart,
      productListCart.map((item) => jsonEncode(item)).toList(),
    );
    await _storage.setStorageListData(
      StorageKeys.products,
      products.map((item) => jsonEncode(item)).toList(),
    );
  }
}
