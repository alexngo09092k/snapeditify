import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/providers/edit_image_state.dart';
import 'package:snapedit/utils/image.dart';

abstract class EditImageProvider extends Provider {
  Future<bool> setImage(BuildContext context, {required File file, bool refesh = true}) async {
    /// RENEW STATE
    if (refesh) await refresh(context);

    /// CREATE IMAGE JPEG FILE
    _imageFile = file;

    /// ENCODE BASE 64 IMAGE
    _imageBase64 = base64.encode(file.readAsBytesSync());

    /// CREATE IMAGE UI
    _imageUI = await Image.file(file).image.image;

    Debug.log("====== PROVIDER SET IMAGE DONE ======");

    /// SET IMAGE FOR STATE
    return state.setImage(imageBase64, provider: this, createImageFile: true);
  }

  Future<bool> refresh(BuildContext context);

  Future<bool> saveImage(BuildContext context);

  EditImageState get state;

  late File _imageFile;
  File get imageFile => _imageFile;

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  late String _imageBase64;
  String get imageBase64 => _imageBase64;
}
