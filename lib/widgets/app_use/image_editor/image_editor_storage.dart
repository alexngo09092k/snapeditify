import 'dart:ui';

import 'data/layer.dart';

class ImageEditorStorage {
  static final ImageEditorStorage _instance = ImageEditorStorage.internal();

  static ImageEditorStorage get instance => _instance;

  ImageEditorStorage.internal();

  Size viewportSize = const Size(0, 0);
  double viewportRatio = 1;

  List<Layer> layers = [], undoLayers = [], removedLayers = [];
}
