import 'package:flutter/material.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/view_models/enhanced_vm.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/view_models/face_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';

class EnhanceState extends EditImageState {
  EnhanceState() {
    _paintBefore = PainterController();
    _paintBefore.addListener(notifyState);

    _paintAfter = PainterController();
    _paintAfter.addListener(notifyState);

    _paintSize = Size.zero;
  }

  @override
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider, bool createImageFile = true}) async {
    final bool result = await super.setImage(imageBase64);
    if (result) {
      _paintBefore.background = image.imageUI.backgroundDrawable;
      _paintAfter.background = image.imageUI.backgroundDrawable;
      _paintSize = image.size;
    }
    return result;
  }

  /// PAINT
  late PainterController _paintBefore;
  PainterController get paintBefore => _paintBefore;

  late PainterController _paintAfter;
  PainterController get paintAfter => _paintAfter;

  late Size _paintSize;
  Size get paintSize => _paintSize;
  set paintSize(Size size) {
    if (_paintSize != size) {
      _paintSize = size;
      notifyState();
    }
  }

  String? _imageId;
  String? get imageId => _imageId;
  set imageId(String? value) {
    _imageId = value;
    notifyState();
  }

  int _enhancedImageIndex = 0;
  int get enhancedImageIndex => _enhancedImageIndex;
  set enhancedImageIndex(int value) {
    _enhancedImageIndex = value;
    notifyState();
  }

  final List<EnhancedVM> _enhancedImages = [];
  List<EnhancedVM> get enhancedImages => _enhancedImages;
  set enhancedImages(List<EnhancedVM> value) {
    _enhancedImages.clear();
    _enhancedImages.addAll(value);
    notifyState();
  }

  final List<FaceVM> _faces = [];
  List<FaceVM> get faces => _faces;
  set faces(List<FaceVM> value) {
    _faces.clear();
    _faces.addAll(value);
    notifyState();
  }

  @override
  void dispose() {
    _paintBefore.dispose();
    _paintAfter.dispose();
    super.dispose();
  }
}
