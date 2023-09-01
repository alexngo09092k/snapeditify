import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:snapeditify/utils/image.dart';

class EditingImageVM {
  EditingImageVM(Uint8List imageBytes) {
    _imageBytes = imageBytes;
  }

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  late Uint8List _imageBytes;
  Uint8List get imageBytes => _imageBytes;

  String get imageBase64 => base64.encode(_imageBytes);

  Future<void> paintParse() async {
    _imageUI = await ImageUtils.instance.toImageUI(imageBytes);
  }

  ui.Size get size => ui.Size(_imageUI.width.toDouble(), _imageUI.height.toDouble());

  double get ratio => size.width / size.height;
}
