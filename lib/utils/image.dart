import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as imagepkg;
import 'package:snapeditify/widgets/app_use/painter/extensions/extensions.dart';

class ImageUtils {
  static final ImageUtils _instance = ImageUtils._internal();

  static ImageUtils get instance => _instance;

  ImageUtils._internal() {
    _imagePicker = ImagePicker();
  }

  late ImagePicker _imagePicker;

  /// Pick image from camera or gallery
  Future<File?> pickImage(ImageSource from, {int? quality, Function(File)? onImage}) async {
    try {
      XFile? pickedFile = await _imagePicker.pickImage(
        source: from,
        imageQuality: quality,
      );
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        if (onImage != null) onImage(image);
        return image;
      }
    } catch (error) {
      Debug.log('PICK IMAGE ERROR $error');
    }
    return null;
  }

  Future<ui.Image> toImageUI(Uint8List imageBytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<Uint8List?> imageUIToBytes(ui.Image image) async {
    Uint8List? imageBytes = await image.pngBytes;
    return imageBytes;
  }

  Future<Uint8List> cropImage(Uint8List imageBytes, {required ui.Size size, required ui.Offset position}) async {
    imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    imagepkg.Image destImage = imagepkg.copyCrop(
      src!,
      x: position.dx.toInt(),
      y: position.dy.toInt(),
      width: size.width.toInt(),
      height: size.height.toInt(),
    );

    return imagepkg.encodePng(destImage);
  }

  Future<Uint8List> toJPG(Uint8List imageBytes) async {
    imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    return imagepkg.encodeJpg(src!);
  }

  Future<Uint8List> toPNG(Uint8List imageBytes) async {
    imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    return imagepkg.encodePng(src!);
  }
}
