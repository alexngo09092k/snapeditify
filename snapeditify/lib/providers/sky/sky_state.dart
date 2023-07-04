import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/widgets/painter/painter_pure.dart';

class SkyState extends EditImageState {
  SkyState() {
    _paint = PainterController();
    _paint.addListener(notifyState);
  }

  /// PAINT
  late PainterController _paint;
  PainterController get paint => _paint;

  String? _styleId;
  String? get styleId => _styleId;

  final Map<String, String> _styledImages = {};
  Map<String, String> get styledImages => _styledImages;
  set styledImages(Map<String, String> styledImages) {
    _styledImages.clear();
    _styledImages.addAll(styledImages);
    notifyState();
  }

  final Map<String, String> _videoEffects = {};
  Map<String, String> get videoEffects => _videoEffects;
  set videoEffects(Map<String, String> videoEffects) {
    _videoEffects.clear();
    _videoEffects.addAll(videoEffects);
    notifyState();
  }

  @override
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider, String? styleId}) async {
    await super.setImage(imageBase64);
    _styleId = styleId;
    _paint.background = (image.imageUI).backgroundDrawable;
    return true;
  }

  @override
  void dispose() {
    _paint.dispose();
    _styledImages.clear();
    super.dispose();
  }
}
