import 'package:firebase_storage/firebase_storage.dart';

import 'package:quickfood/domain_layer/domain_layer.dart';
import 'package:quickfood/infra/infra.dart';

class UploadImageUseCase {
  final ImageRepositoryInterface _repository;

  UploadImageUseCase({
    required ImageRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<UploadTask>> call({
    required StorageType storageType,
    required String path,
  }) async {
    return await _repository.uploadImage(
      storageType: storageType,
      path: path,
    );
  }
}
