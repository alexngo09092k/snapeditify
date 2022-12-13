import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/providers/edit_image_state.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';

class EnhanceState extends EditImageState {
  EnhanceState() {
    _paint = PainterController();
    _paint.addListener(notifyListeners);
  }

  /// PAINT
  late PainterController _paint;
  PainterController get paint => _paint;

  late String? _imageId;
  String? get imageId => _imageId;
  set imageId(String? value) {
    _imageId = value;
    notifyListeners();
  }

  EnhanceState copyWith({String? imageId}) {
    return EnhanceState()..imageId = imageId ?? this.imageId;
  }

  @override
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider, bool createImageFile = true}) async {
    await super.setImage(imageBase64, provider: provider, createImageFile: createImageFile);
    _paint.background = imageUI.backgroundDrawable;
    return true;
  }

  @override
  void dispose() {
    _paint.dispose();
    super.dispose();
  }
}
