import 'dart:typed_data';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';

class EnhanceState extends EditImageState {
  EnhanceState() {
    _paint = PainterController();
    _paint.addListener(notifyState);
  }

  @override
  Future<bool> setImage(Uint8List imageBytes, String imageBase64, {String? imageId}) async {
    final bool result = await super.setImage(imageBytes, imageBase64);
    if (result) {
      _paint.background = image.imageUI.backgroundDrawable;
      _imageId = imageId;
    }
    return result;
  }

  late PainterController _paint;
  PainterController get paint => _paint;

  String? _imageId;
  String? get imageId => _imageId;

  @override
  void dispose() {
    _paint.dispose();
    super.dispose();
  }
}
