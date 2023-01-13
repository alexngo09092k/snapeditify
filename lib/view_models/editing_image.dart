import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:phosart/utils/image.dart';

class EditingImage {
  EditingImage(String imageBase64) {
    _imageBase64 = imageBase64;
  }

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  late String _imageBase64;
  String get imageBase64 => _imageBase64;

  Uint8List get imageBytes => base64.decode(_imageBase64);

  Future<void> paintParse() async {
    _imageUI = await ImageUtils.instance.base64ToImageUI(imageBase64);
  }

  ui.Size get size => ui.Size(_imageUI.width.toDouble(), _imageUI.height.toDouble());

  double get ratio => size.width / size.height;
}
