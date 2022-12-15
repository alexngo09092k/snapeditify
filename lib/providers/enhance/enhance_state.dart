import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:snapedit/view_models/enhance_vm.dart';
import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/providers/edit_image_state.dart';
import 'package:snapedit/utils/image.dart';
import 'package:snapedit/widgets/painter/painter.dart';

class EnhanceState extends EditImageState {
  EnhanceState() {
    _paintBefore = PainterController();
    _paintBefore.addListener(notifyListeners);

    _paintAfter = PainterController();
    _paintAfter.addListener(notifyListeners);
  }

  /// PAINT
  late PainterController _paintBefore;
  PainterController get paintBefore => _paintBefore;

  late PainterController _paintAfter;
  PainterController get paintAfter => _paintAfter;

  String? _imageId;
  String? get imageId => _imageId;
  set imageId(String? value) {
    _imageId = value;
    notifyListeners();
  }

  final Map<String, ui.Image> _enhancedImageUIList = {};

  Map<String, ui.Image> get enhancedImageUIList => _enhancedImageUIList;

  final List<String> _enhancedImageBase64List = [];

  List<String> get enhancedImageBase64List => _enhancedImageBase64List;

  @override
  Future<bool> setImage(
    String imageBase64, {
    List<String>? enhancedImageBase64List,
    EditImageProvider? provider,
    bool createImageFile = false,
  }) async {
    super.setImage(imageBase64, provider: provider, createImageFile: createImageFile);

    if (enhancedImageBase64List != null) {
      _enhancedImageBase64List.addAll(enhancedImageBase64List);
      for (var enhancedImageBase64 in _enhancedImageBase64List) {
        _enhancedImageUIList[enhancedImageBase64] = (await ImageUtils.instance.base64ToImageUI(enhancedImageBase64));
      }
    }

    _paintBefore.background = imageUI.backgroundDrawable;

    if (_enhancedImageUIList.isNotEmpty) {
      _paintAfter.background = _enhancedImageUIList.values.first.backgroundDrawable;
    } else {
      _paintAfter.background = imageUI.backgroundDrawable;
    }

    return true;
  }

  final Map<int, FaceVM> _faces = {};
  Map<int, FaceVM> get faces => _faces;
  set faces(Map<int, FaceVM> value) {
    _faces.clear();
    _faces.addAll(value);
    _paintParseAfterEnahance();
    notifyListeners();
  }

  @override
  void dispose() {
    _paintBefore.dispose();
    _paintAfter.dispose();
    super.dispose();
  }
}

extension EnhanceImageHandler on EnhanceState {
  _paintParseAfterEnahance() async {
    for (var detectedObject in _faces.values) {
      final renderBox = _paintAfter.painterKey.currentContext?.findRenderObject() as RenderBox?;

      /// PAINT PARSE DATA TO USE
      await detectedObject.paintParse(
        realSize: ui.Size(imageUI.width.toDouble(), imageUI.height.toDouble()),
        viewSize: renderBox!.size,
        originalImageBase64: imageBase64,
        enhancedImageBase64List: enhancedImageBase64List,
      );
    }
  }
}
