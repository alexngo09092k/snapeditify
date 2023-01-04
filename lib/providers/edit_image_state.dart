import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/utils/image.dart';

abstract class EditImageState extends ChangeNotifier {
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider}) async {
    _imageBase64 = imageBase64;

    /// CREATE IMAGE UI
    _imageUI = provider != null ? provider.imageUI : await ImageUtils.instance.base64ToImageUI(imageBase64);

    /// DECODE IMAGE BASE64
    _imageBytes = base64.decode(imageBase64);

    Debug.log("====== STATE SET IMAGE DONE ======");

    return true;
  }

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  late String _imageBase64;
  String get imageBase64 => _imageBase64;

  late Uint8List _imageBytes;
  Uint8List get imageBytes => _imageBytes;
}
