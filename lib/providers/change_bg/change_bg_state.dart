import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
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
  Future<bool> setImage(Uint8List imageBytes, String imageBase64, {EditImageProvider? provider, bool createImageFile = true}) async {
    final bool result = await super.setImage(imageBytes, imageBase64);
    if(result) {
      paint.addImage(ImageDrawer(image: image.imageUI));
      ratio = image.ratio;
    }
    return result;
  }
}
