import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickfood/infra/infra.dart';
import 'package:quickfood/domain_layer/domain_layer.dart';
import '../../data_layer.dart';

class ImageRepository implements ImageRepositoryInterface {
  final ImageDataSource _dataSource;

  ImageRepository({
    required ImageDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Result<UploadTask>> uploadImage({
    required StorageType storageType,
    required String path,
  }) async {
    return await _dataSource.uploadImage(
      storageType: storageType,
      path: path,
    );
  }
}
