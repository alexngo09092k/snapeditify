import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttering/fluttering.dart';

Future<File?> uint8ListToFile(Uint8List imageBytes) async {
  try {
    final File imageFile = File('/${DateTime.now().millisecondsSinceEpoch}.jpg');
    imageFile.writeAsBytesSync(List.from(imageBytes));
    final Directory tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageBytes);
    if (await imageFile.exists()) {
      return imageFile;
    }
  } catch (error) {
    Debug.log(error);
    return null;
  }
  return null;
}

Future<File?> compressImageFile(
  File file, {
  int minWidth = 1000,
  int minHeight = 1000,
  int quality = 95,
  CompressFormat format = CompressFormat.jpeg,
}) async {
  final filePath = file.absolute.path;
  final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  File? compressedFile = await FlutterImageCompress.compressAndGetFile(
    filePath,
    outPath,
    minWidth: minWidth,
    minHeight: minHeight,
    quality: quality,
    format: format,
  );
  return compressedFile;
}
