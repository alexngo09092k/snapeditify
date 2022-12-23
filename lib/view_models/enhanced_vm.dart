import 'package:snapedit/providers/enhance/enhance_state.dart';
import 'package:snapedit/widgets/painter/painter.dart';
import 'dart:ui' as ui;

import 'package:snapedit/utils/image.dart';

class EnhancedVM {
  final int index;
  final String imageBase64;
  final EnhanceState state;

  EnhancedVM({
    required this.index,
    required this.imageBase64,
    required this.state,
  });

  ui.Image? _imageUI;
  ui.Image? get imageUI => _imageUI;

  Future<bool> paintParse() async {
    _imageUI = await ImageUtils.instance.base64ToImageUI(imageBase64);
    return true;
  }

  onSelect() {
    if (state.enhancedImageIndex != index) {
      if (imageUI == null) return;
      state.paintBefore.background = state.imageUI.backgroundDrawable;
      state.paintAfter.background = _imageUI!.backgroundDrawable;
    }
  }
}
