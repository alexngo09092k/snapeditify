import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

class EditedImageVM {
  EditedImageVM(Uint8List imageBytes, ui.Image imageUI) {
    _imageBytes = imageBytes;
    _imageBase64 = base64.encode(imageBytes);
    _imageUI = imageUI;
  }

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  late Uint8List _imageBytes;
  Uint8List get imageBytes => _imageBytes;

  late String _imageBase64;
  String get imageBase64 => _imageBase64;

  ui.Size get size => ui.Size(_imageUI.width.toDouble(), _imageUI.height.toDouble());

  double get ratio => size.width / size.height;
}
