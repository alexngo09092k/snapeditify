import 'package:phosart/providers/edit_image_provider.dart';
import 'package:phosart/providers/edit_image_state.dart';
import 'package:phosart/widgets/painter/painter.dart';

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
  set imageId(String? imageId) {
    _imageId = imageId;
    notifyListeners();
  }

  String? _styleId;
  String? get styleId => _styleId;

  final Map<String, String> _styledImages = {};
  Map<String, String> get styledImages => _styledImages;
  set styledImages(Map<String, String> styledImages) {
    _styledImages.clear();
    _styledImages.addAll(styledImages);
    notifyListeners();
  }

  @override
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider, String? styleId}) async {
    await super.setImage(imageBase64);
    _styleId = styleId;
    _paint.background = image.imageUI.backgroundDrawable;
    return true;
  }

  @override
  void dispose() {
    _paint.dispose();
    _styledImages.clear();
    super.dispose();
  }
}
