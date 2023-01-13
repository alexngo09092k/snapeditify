import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

class EditedImageVM {
  EditedImageVM(String imageBase64, ui.Image imageUI) {
    _imageBase64 = imageBase64;
    _imageUI = imageUI;
  }

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  late String _imageBase64;
  String get imageBase64 => _imageBase64;

  Uint8List get imageBytes => base64.decode(_imageBase64);

  ui.Size get size => ui.Size(_imageUI.width.toDouble(), _imageUI.height.toDouble());

  double get ratio => size.width / size.height;
}
