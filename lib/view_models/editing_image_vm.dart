import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:snapeditify/utils/image.dart';

class EditingImageVM {
  EditingImageVM({required Uint8List imageBytes, required String imageBase64}) {
    _imageBase64 = imageBase64;
    _imageBytes = imageBytes;
  }

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  late Uint8List _imageBytes;
  Uint8List get imageBytes => _imageBytes;

  late String _imageBase64;
  String get imageBase64 => _imageBase64;

  Future<void> paintParse() async {
    _imageUI = await ImageUtils.instance.toImageUI(imageBytes);
  }

  ui.Size get size => ui.Size(_imageUI.width.toDouble(), _imageUI.height.toDouble());

  double get ratio => size.width / size.height;
}
