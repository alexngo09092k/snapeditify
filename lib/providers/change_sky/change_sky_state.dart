import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

class ChangeSkyState extends EditImageState {
  ChangeSkyState() {
    _paint = PainterController();
    _paint.addListener(notifyState);
  }

  /// PAINT
  late PainterController _paint;
  PainterController get paint => _paint;

  Background? _sky;
  Background? get sky => _sky;
  set sky(Background? newSky) {
    if(newSky == _sky) return;
    _sky = newSky;
    notifyListeners();
  }

  Uint8List _mask = Uint8List.fromList([]);
  set mask(Uint8List newMask) {
    if(newMask == _mask) return;
    _mask = newMask;
    notifyState();
  }
  Uint8List get mask => _mask;

  final Map<String, ui.Image> _styledImages = {};
  Map<String, ui.Image> get styledImages => _styledImages;
  set styledImages(Map<String, ui.Image> styledImages) {
    _styledImages.clear();
    _styledImages.addAll(styledImages);
    notifyState();
  }

  @override
  Future<bool> setImage(Uint8List imageBytes, String imageBase64, {EditImageProvider? provider}) async {
    final bool result = await super.setImage(imageBytes, imageBase64);
    if(result) {
      // /// Clean
      // paint.clearDrawables(saveAction: false);

      // /// Fake Background Image
      // Uint8List noImageBytes = (await rootBundle.load(AppAssets.instance.noImage)).buffer.asUint8List();
      // ui.Image noImage = await ImageUtils.instance.toImageUI(noImageBytes);
      // late ImageDrawable noImageDrawable;
      // noImageDrawable = ImageDrawable(position: Offset.zero, image: noImage);

      // /// Add Image
      // paint.addDrawables([noImageDrawable]);
      paint.background = image.imageUI.backgroundDrawable;
    }

    return result;
  }

  @override
  void dispose() {
    _paint.dispose();
    _styledImages.clear();
    super.dispose();
  }
}
