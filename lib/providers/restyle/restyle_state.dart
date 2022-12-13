import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/providers/edit_image_state.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';

class RestyleState extends EditImageState {
  RestyleState() {
    _paint = PainterController();
    _paint.addListener(notifyListeners);
  }

  /// PAINT
  late PainterController _paint;
  PainterController get paint => _paint;

  String? _imageId;
  String? get imageId => _imageId;
  set(String? imageId) {
    _imageId = imageId;
    notifyListeners();
  }

  @override
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider, bool createImageFile = true}) async {
    await super.setImage(imageBase64, provider: provider, createImageFile: createImageFile);
    _paint.background = imageUI.backgroundDrawable;
    return true;
  }

  RestyleState copyWith({String? imageId}) {
    return RestyleState().._imageId = imageId ?? this.imageId;
  }

  @override
  void dispose() {
    _paint.dispose();
    super.dispose();
  }
}
