import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/utils/image.dart';

abstract class EditImageState extends ChangeNotifier {
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider, bool createImageFile = true}) async {
    _imageBase64 = imageBase64;

    /// CREATE IMAGE UI
    _imageUI = provider != null ? provider.imageUI : await ImageUtils.instance.base64ToImageUI(imageBase64);

    /// CREATE FILE
    if (createImageFile) {
      _imageFile = await ManagerCache.instance.cacheImageBase64(imageBase64);
      // _imageFile = ImageUtils.instance.pngToJpeg(_imageFile!);
    }

    Debug.log("====== STATE SET IMAGE DONE ======");

    return true;
  }

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  File? _imageFile;
  File? get imageFile => _imageFile;

  late String _imageBase64;
  String get imageBase64 => _imageBase64;

  @override
  void dispose() {
    if (_imageFile != null) {
      ManagerCache.instance.removeFile(_imageFile!);
    }
    super.dispose();
  }
}
