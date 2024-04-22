import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickfood/infra/infra.dart';

class ImageDataSource {
  final FirebaseStorage _firebase;

  ImageDataSource({
    required FirebaseStorage firebase,
  }) : _firebase = firebase;

  Future<Result<UploadTask>> uploadImage({
    required StorageType storageType,
    required String path,
  }) async {
    File file = File(path);
    try {
      print(storageType.toString());
      String ref =
          '${storageType.toString()}/img-${DateTime.now().toString()}.jpeg';

      final storageRef = _firebase.ref();
      final response = storageRef.child(ref).putFile(
          file,
          SettableMetadata(
            cacheControl: "public, max-age=300",
            contentType: "image/jpeg",
            customMetadata: {
              "user": "123",
            },
          ));

      print(response);

      return Result.success(response);
    } on FirebaseException catch (e) {
      print(e.message);
      return Result.error(FailureError(e));
    }
  }

  // deleteImage(int index) async {
  //   await storage.ref(refs[index].fullPath).delete();
  //   arquivos.removeAt(index);
  //   refs.removeAt(index);
  //   setState(() {});
  // }
}
