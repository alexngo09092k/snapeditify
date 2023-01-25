import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snapeditify/view_models/editing_image_vm.dart';

abstract class EditImageState extends ChangeNotifier {
  Future<bool> setImage(String imageBase64) async {
    _image = EditingImageVM(imageBase64);
    await _image.paintParse();
    return true;
  }

  late EditingImageVM _image;
  EditingImageVM get image => _image;
}
