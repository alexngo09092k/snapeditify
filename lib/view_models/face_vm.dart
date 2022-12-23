import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/providers/enhance/enhance_state.dart';
import 'package:snapedit/services/services.dart';
import 'package:snapedit/widgets/painter/painter.dart';
import 'dart:ui' as ui;

import 'package:snapedit/utils/image.dart';

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

  ui.Image? faceImage;

  final List<ui.Image> _faceEnhancedImages = [];

  List<ui.Image> get faceEnhancedImages => _faceEnhancedImages;

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
    ui.Image? faceImage,
    List<ui.Image>? faceEnhancedImages,
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

    if (box.length > 3) {
      ui.Offset realBoxPosition = ui.Offset(box[0].toDouble(), box[1].toDouble());
      ui.Size realBoxSize = ui.Size((box[2] - box[0]).toDouble(), (box[3] - box[1]).toDouble());

      double ratioX = viewSize.width / realSize.width;
      double ratioY = viewSize.height / realSize.height;

      ui.Size size = ui.Size(realBoxSize.width * ratioX, realBoxSize.height * ratioY);
      ui.Offset position = ui.Offset(
        realBoxPosition.dx * ratioX + size.width / 2,
        realBoxPosition.dy * ratioX + size.height / 2,
      );

      Debug.log('paintParse $position');
      Debug.log('paintParse $size');

      faceImage = await ImageUtils.instance.base64ToImageUI(
        await ImageUtils.instance.cropImageBase64(
          originalImageBase64,
          size: realBoxSize,
          position: realBoxPosition,
        ),
      );

      for (var enhancedImageBase64 in state.enhancedImages) {
        final faceEnhancedImage = await ImageUtils.instance.base64ToImageUI(
          await ImageUtils.instance.cropImageBase64(
            enhancedImageBase64.imageBase64,
            size: realBoxSize,
            position: realBoxPosition,
          ),
        );
        _faceEnhancedImages.add(faceEnhancedImage);
      }
    }
  }

  onSelect() {
    if (!isSelected) {
      state.paintAfter.background = faceEnhancedImages[state.enhancedImageIndex].backgroundDrawable;
      state.paintBefore.background = faceImage!.backgroundDrawable;
      isSelected = true;
    }
  }
}
