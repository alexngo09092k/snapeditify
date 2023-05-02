import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/widgets/painter/painter.dart';

class RestoreState extends EditImageState {
  RestoreState() {
    _paint = PainterController();
    _paint.addListener(notifyState);
  }

  /// PAINT
  late PainterController _paint;
  PainterController get paint => _paint;

  String? _imageId;
  String? get imageId => _imageId;
  set imageId(String? value) {
    _imageId = value;
    notifyState();
  }

  String? _styleId;
  String? get styleId => _styleId;

  @override
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider, String? styleId}) async {
    final bool result = await super.setImage(imageBase64);
    if (result) {
      _styleId = styleId;
      _paint.background = image.imageUI.backgroundDrawable;
    }
    return result;
  }

  @override
  void dispose() {
    _paint.dispose();
    super.dispose();
  }
}
