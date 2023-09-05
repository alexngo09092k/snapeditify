import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/image.dart';
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

  Background? _bgBG;
  set bgBG(Background? newBG) {
    if(_bgBG == newBG) return;
    _bgBG = newBG;
    notifyState();
  }
  Background? get bgBG => _bgBG;

  Color? _bgColor;
  set bgColor(Color? newColor) {
    if(_bgColor == newColor) return;
    _bgColor = newColor;
    notifyState();
  }
  Color? get bgColor => _bgColor;

  @override
  Future<bool> setImage(Uint8List imageBytes, String imageBase64, {Size size = Size.infinite}) async {
    final bool result = await super.setImage(imageBytes, imageBase64);
    if(result) {
      /// Clean
      paint.clearDrawables(saveAction: false);

      /// Fake Background Image
      Uint8List noImageBytes = (await rootBundle.load(AppAssets.instance.noImage)).buffer.asUint8List();
      ui.Image noImage = await ImageUtils.instance.toImageUI(noImageBytes);
      paint.addDrawables([ImageDrawable.fittedToSize(position: Offset.zero, size: size, image: noImage)]);

      /// Add Image
      paint.addDrawables([ImageDrawable.fittedToSize(position: Offset.zero, size: size, image: image.imageUI)]);
    }
    return result;
  }
}
