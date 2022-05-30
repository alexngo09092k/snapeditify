import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as imagepkg;
import 'package:snapedit/modules/painter/painter.dart';

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

  static Future<ui.Image> imagePathToImage(String imagePath) async {
    Uint8List imageBytes = File(imagePath).readAsBytesSync();
    ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
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
}
