import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

class EditedImageVM {
  EditedImageVM(Uint8List imageBytes, ui.Image imageUI) {
    _imageBytes = imageBytes;
    _imageUI = imageUI;
  }

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  late Uint8List _imageBytes;
  Uint8List get imageBytes => _imageBytes;

  String get imageBase64 => base64.encode(_imageBytes);

  ui.Size get size => ui.Size(_imageUI.width.toDouble(), _imageUI.height.toDouble());

  double get ratio => size.width / size.height;
}
