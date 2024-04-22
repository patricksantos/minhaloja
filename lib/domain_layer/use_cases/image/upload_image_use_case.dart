import 'package:firebase_storage/firebase_storage.dart';

import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/infra/infra.dart';

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
