import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image/image.dart' as imagepkg;
import 'package:snapedit/widgets/painter/painter.dart';

class ImageConvert {
  static final ImageConvert _instance = ImageConvert._internal();

  ImageConvert get instance => _instance;

  ImageConvert._internal();

  static Future<ui.Image> base64ToImage(String imageBase64) async {
    Uint8List imageBytes = base64.decode(imageBase64);
    ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  static Future<String> imageToBase64(ui.Image image) async {
    Uint8List? imageBytes = await image.pngBytes;
    if (imageBytes != null) {
      return base64.encode(imageBytes);
    }
    return '';
  }

  static String imagePathToBase64(String imagePath) {
    return base64.encode(File(imagePath).readAsBytesSync());
  }

  static String uint8ListToBase64(Uint8List bytes) {
    return base64.encode(bytes);
  }

  static Future<ui.Image> imagePathToImage(String imagePath) async {
    return await (kIsWeb ? Image.network(imagePath).image.image : Image.file(File(imagePath)).image.image);
  }

  static Future<Uint8List> cropImagePath({
    required String imagepath,
    required ui.Size size,
    required ui.Offset position,
  }) async {
    var bytes = await File(imagepath).readAsBytes();
    imagepkg.Image? src = imagepkg.decodeImage(bytes);
    imagepkg.Image destImage = imagepkg.copyCrop(
      src!,
      position.dx.toInt(),
      position.dy.toInt(),
      size.width.toInt(),
      size.height.toInt(),
    );
    return destImage.getBytes();
  }

  static Future<String> cropImageString({
    required String imageBase64,
    required ui.Size size,
    required ui.Offset position,
  }) async {
    Uint8List imageBytes = base64.decode(imageBase64);
    imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    imagepkg.Image destImage = imagepkg.copyCrop(
      src!,
      position.dx.toInt(),
      position.dy.toInt(),
      size.width.toInt(),
      size.height.toInt(),
    );

    return base64.encode(imagepkg.encodePng(destImage));
  }

  static Future<File?> compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    File? cacheFile = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      minWidth: 1000,
      minHeight: 1000,
      quality: 95,
    );
    ManagerCache.instance.addFile(cacheFile);
    return cacheFile;
  }

  static File pngToJpeg(File file) {
    final name = file.path.split('.').first;
    final image = imagepkg.decodeImage(file.readAsBytesSync())!;

    return File('$name.jpeg')..writeAsBytesSync(imagepkg.encodeJpg(image));
  }
}
