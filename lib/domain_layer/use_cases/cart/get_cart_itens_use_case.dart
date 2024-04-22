import 'dart:convert';

import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class GetCartItensUseCase {
  final StorageRepositoryInterface _storage;

  GetCartItensUseCase({
    required StorageDataSource storage,
  }) : _storage = storage;

  Future<List<ProductListCart>?> call() async {
    final response = await _storage.getStorageListData(
      StorageKeys.cart,
    );
    if (response != null) {
      List<dynamic> list = response.map((item) => jsonDecode(item)).toList();
      List<ProductListCart> products =
          list.map((item) => ProductListCartDTO.fromJson(item)).toList();
      return products;
    }
    return null;
  }
}
