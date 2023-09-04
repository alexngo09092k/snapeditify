import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

class ChangeBackgroundState extends EditImageState {
  ChangeBackgroundState() {
    _paint = PainterController();
    _paint.addListener(notifyState);
  }

  late PainterController _paint;
  PainterController get paint => _paint;

  Uint8List _mask = Uint8List.fromList([]);
  set mask(Uint8List newMask) {
    if(newMask == _mask) return;
    _mask = newMask;
    notifyState();
  }
  Uint8List get mask => _mask;

  String? _bgImage;
  set bgImage(String? newImage) {
    if(_bgImage == newImage) return;
    _bgImage = newImage;
    notifyState();
  }
  String? get bgImage => _bgImage;

  Color? _bgColor;
  set bgColor(Color? newColor) {
    if(_bgColor == newColor) return;
    _bgColor = newColor;
    notifyState();
  }
  Color? get bgColor => _bgColor;

  @override
  Future<bool> setImage(Uint8List imageBytes, String imageBase64) async {
    final bool result = await super.setImage(imageBytes, imageBase64);
    if(result) {
      paint.addImage(ImageDrawer(position: Offset.zero, image: image.imageUI));
    }
    return result;
  }
}
