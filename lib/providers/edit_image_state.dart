import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/view_models/editing_image.dart';

abstract class EditImageState extends ChangeNotifier {
  Future<bool> setImage(String imageBase64) async {
    _image = EditingImage(imageBase64);
    Debug.log("====== STATE SET IMAGE DONE ======");
    return true;
  }

  late EditingImage _image;
  EditingImage get image => _image;
}
