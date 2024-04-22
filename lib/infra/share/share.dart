import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class TBShare {
  static Future shareFile({
    required String name,
    required Uint8List bytes,
    required String contentType,
  }) async {
    Directory dir = await getTemporaryDirectory();
    File tempFile = File('${dir.path}/$name');
    if (!await tempFile.exists()) {
      await tempFile.create(recursive: true);
      await tempFile.writeAsBytes(bytes);
    }

    return Share.shareXFiles(
      [XFile(tempFile.path, mimeType: contentType)],
    );
  }
}
