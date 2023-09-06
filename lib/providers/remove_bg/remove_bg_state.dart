import 'package:flutter/services.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

class RemoveBGState extends EditImageState {
  RemoveBGState() {
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

  @override
  Future<bool> setImage(Uint8List imageBytes, String imageBase64) async {
    final bool result = await super.setImage(imageBytes, imageBase64);
    return result;
  }
}
