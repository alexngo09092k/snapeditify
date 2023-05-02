import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:image/image.dart' as imagepkg;
import 'package:snapeditify/widgets/painter/extensions/extensions.dart';

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

  Future<ui.Image> base64ToImageUI(String imageBase64) async {
    Uint8List imageBytes = base64.decode(imageBase64);
    ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<String?> imageUIToBase64(ui.Image image) async {
    Uint8List? imageBytes = await image.pngBytes;
    if (imageBytes != null) {
      return base64.encode(imageBytes);
    }
    return null;
  }

  Future<String> cropImageBase64(String imageBase64, {required ui.Size size, required ui.Offset position}) async {
    Uint8List imageBytes = base64.decode(imageBase64);
    imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    imagepkg.Image destImage = imagepkg.copyCrop(
      src!,
      x: position.dx.toInt(),
      y: position.dy.toInt(),
      width: size.width.toInt(),
      height: size.height.toInt(),
    );

    return base64.encode(imagepkg.encodePng(destImage));
  }
}
