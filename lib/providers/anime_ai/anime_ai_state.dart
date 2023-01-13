import 'package:phosart/providers/edit_image_provider.dart';
import 'package:phosart/providers/edit_image_state.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_image_response.dart';
import 'package:phosart/widgets/painter/painter_pure.dart';

class AnimeAIState extends EditImageState {
  AnimeAIState() {
    _paint = PainterController();
    _paint.addListener(notifyListeners);
  }

  /// PAINT
  late PainterController _paint;
  PainterController get paint => _paint;

  String? _styleId;
  String? get styleId => _styleId;

  final Map<String, AnimeImageResponse> _styledImages = {};
  Map<String, AnimeImageResponse> get styledImages => _styledImages;
  set styledImages(Map<String, AnimeImageResponse> styledImages) {
    _styledImages.clear();
    _styledImages.addAll(styledImages);
    notifyListeners();
  }

  final Map<String, String> _videoEffects = {};
  Map<String, String> get videoEffects => _videoEffects;
  set videoEffects(Map<String, String> videoEffects) {
    _videoEffects.clear();
    _videoEffects.addAll(videoEffects);
    notifyListeners();
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
