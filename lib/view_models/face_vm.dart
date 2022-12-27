import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/providers/enhance/enhance_state.dart';
import 'package:snapedit/services/services.dart';
import 'package:snapedit/utils/image.dart';
import 'package:snapedit/widgets/painter/painter.dart';
import 'dart:ui' as ui;

class FaceVM extends Face with Provider {
  FaceVM({
    required super.box,
    required super.faceId,
    required super.png,
    required this.state,
  });

  factory FaceVM.fromFace(Face face, EnhanceState state) {
    return FaceVM(
      box: face.box,
      faceId: face.faceId,
      png: face.png,
      state: state,
    );
  }

  EnhanceState state;

  Future<String>? faceImage;

  final List<Future<String>> _faceEnhancedImages = [];

  List<Future<String>> get faceEnhancedImages => _faceEnhancedImages;

  bool _isSelected = false;
  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    if (_isSelected != value) {
      _isSelected = value;
      notifyListeners();
    }
  }

  @override
  FaceVM copyWith({
    List<int>? box,
    int? faceId,
    List<String>? png,
    bool? isSelected,
    Future<String>? faceImage,
    List<Future<String>>? faceEnhancedImages,
    EnhanceState? state,
  }) {
    return FaceVM(
      box: box ?? this.box,
      faceId: faceId ?? this.faceId,
      png: png ?? this.png,
      state: state ?? this.state,
    )
      ..faceImage = faceImage ?? this.faceImage
      ..faceEnhancedImages.addAll(faceEnhancedImages ?? this.faceEnhancedImages)
      ..isSelected = isSelected ?? this.isSelected;
  }

  Future<void> paintParse() async {
    final renderBox = state.paintAfter.painterKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    ui.Size realSize = ui.Size(state.imageUI.width.toDouble(), state.imageUI.height.toDouble());
    ui.Size viewSize = renderBox.size;
    String originalImageBase64 = state.imageBase64;
    

    /// BOX [x, y, width, height]
    if (box.length > 3) {
      ui.Offset realBoxPosition = ui.Offset(box[0].toDouble(), box[1].toDouble());
      ui.Size realBoxSize = ui.Size((box[2]).toDouble(), (box[3]).toDouble());

      double ratioX = viewSize.width / realSize.width;
      double ratioY = viewSize.height / realSize.height;

      Debug.log(ratioX);
      Debug.log(ratioY);

      ui.Size size = ui.Size(realBoxSize.width * ratioX, realBoxSize.height * ratioY);
      ui.Offset position = ui.Offset(
        realBoxPosition.dx * ratioX + size.width / 2,
        realBoxPosition.dy * ratioX + size.height / 2,
      );

      Debug.log('paintParse $position');
      Debug.log('paintParse $size');

      faceImage = ImageUtils.instance.cropImageBase64(
        originalImageBase64,
        size: realBoxSize,
        position: realBoxPosition,
      );

      for (var enhancedImageBase64 in state.enhancedImages) {
        final faceEnhancedImage = ImageUtils.instance.cropImageBase64(
          enhancedImageBase64.imageBase64,
          size: realBoxSize,
          position: realBoxPosition,
        );
        _faceEnhancedImages.add(faceEnhancedImage);
      }
    }
  }

  onSelect() async {
    if (!isSelected) {
      state.paintAfter.background = (await (Image.memory(base64.decode(await faceImage!)).image).image).backgroundDrawable;
      state.paintBefore.background =
          (await (Image.memory(base64.decode(await _faceEnhancedImages[state.enhancedImageIndex])).image).image).backgroundDrawable;
      isSelected = true;
    }
  }
}
