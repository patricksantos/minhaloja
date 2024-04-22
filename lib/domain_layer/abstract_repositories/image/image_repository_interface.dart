import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickfood/infra/infra.dart';

abstract class ImageRepositoryInterface {
  Future<Result<UploadTask>> uploadImage({
    required StorageType storageType,
    required String path,
  });
}
