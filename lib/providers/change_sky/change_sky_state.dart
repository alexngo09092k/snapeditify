import 'dart:typed_data';

import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

class ChangeSkyState extends EditImageState {
  ChangeSkyState() {
    _paint = PainterController();
    _paint.addListener(notifyState);
  }

  /// PAINT
  late PainterController _paint;
  PainterController get paint => _paint;

  String? _styleId;
  String? get styleId => _styleId;

  final Map<String, Uint8List> _styledImages = {};
  Map<String, Uint8List> get styledImages => _styledImages;
  set styledImages(Map<String, Uint8List> styledImages) {
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
  Future<bool> setImage(Uint8List imageBytes, String imageBase64, {EditImageProvider? provider, String? styleId}) async {
    await super.setImage(imageBytes, imageBase64);
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
