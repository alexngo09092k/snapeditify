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
      return file;
    }
    throw 'Can not create image file';
  } catch (error) {
    Debug.log("UNIT8LIST TO FILE ERROR $error");
    return null;
  }
}
