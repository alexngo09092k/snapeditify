import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/edit_image_state.dart';

class ChangeBackgroundState extends EditImageState {
  ChangeBackgroundState();

  Uint8List _mask = Uint8List.fromList([]);
  set mask(Uint8List newMask) {
    if(newMask == _mask) return;
    _mask = newMask;
    notifyState();
  }
  Uint8List get mask => _mask;

  Color _color = Colors.transparent;
  set color(Color newColor) {
    if(_color == newColor) return;
    _color = newColor;
    notifyState();
  }
  Color get color => _color;

  double _ratio = 1;
  set ratio(double newRatio) {
    if(_ratio == newRatio) return;
    _ratio = newRatio;
    notifyState();
  }
  double get ratio => _ratio;

  @override
  Future<bool> setImage(Uint8List imageBytes, {EditImageProvider? provider, bool createImageFile = true}) async {
    final bool result = await super.setImage(imageBytes);
    if(result) {
      ratio = image.ratio;
    }
    return result;
  }
}
