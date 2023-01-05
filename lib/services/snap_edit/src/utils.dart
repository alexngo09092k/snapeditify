import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttering/fluttering.dart';

Future<File?> uint8ListToFile(
  Uint8List imageBytes, {
  int minWidth = 1000,
  int minHeight = 1000,
  int quality = 95,
  CompressFormat format = CompressFormat.jpeg,
}) async {
  try {
    final Directory tempDir = await getTemporaryDirectory();
    File file = File('${tempDir.path}/${(DateTime.now()).millisecond}.jpeg');
    await file.writeAsBytes(imageBytes);
    if (await file.exists()) {
      // final filePath = file.absolute.path;
      // final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      // final splitted = filePath.substring(0, (lastIndex));
      // final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      // File? compressedFile = await FlutterImageCompress.compressAndGetFile(
      //   filePath,
      //   outPath,
      //   minWidth: minWidth,
      //   minHeight: minHeight,
      //   quality: quality,
      //   format: format,
      // );
      // if (compressedFile != null && await compressedFile.exists()) return compressedFile;
      // file.delete();
      return file;
    }
  } catch (error) {
    Debug.log(error);
    return null;
  }
  return null;
}
