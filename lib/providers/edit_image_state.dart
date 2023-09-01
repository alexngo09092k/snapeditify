import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:snapeditify/view_models/editing_image_vm.dart';

abstract class EditImageState extends ChangeNotifier {
  Future<bool> setImage(Uint8List imageBytes) async {
    _image = EditingImageVM(imageBytes);
    await _image.paintParse();
    return true;
  }

  void notifyState() {
    notifyListeners();
  }

  late EditingImageVM _image;
  EditingImageVM get image => _image;
}
