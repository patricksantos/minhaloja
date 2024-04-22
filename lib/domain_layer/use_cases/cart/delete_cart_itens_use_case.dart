import 'package:quickfood/data_layer/data_layer.dart';
import '../../domain_layer.dart';

class DeleteCartItensUseCase {
  final StorageRepositoryInterface _storage;

  DeleteCartItensUseCase({
    required StorageDataSource storage,
  }) : _storage = storage;

  Future<void> call() async {
    await _storage.removeStorage(
      StorageKeys.cart,
    );

    await _storage.removeStorage(
      StorageKeys.products,
    );
  }
}
