import 'dart:convert';

import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class GetProductsStorageUseCase {
  final StorageRepositoryInterface _storage;

  GetProductsStorageUseCase({
    required StorageDataSource storage,
  }) : _storage = storage;

  Future<List<ProductEntity>?> call() async {
    final response = await _storage.getStorageListData(
      StorageKeys.products,
    );
    if (response != null) {
      List<dynamic> list = response.map((item) => jsonDecode(item)).toList();
      List<ProductEntity> products =
          list.map((item) => ProductDTO.fromJson(item)).toList();
      return products;
    }
    return null;
  }
}
