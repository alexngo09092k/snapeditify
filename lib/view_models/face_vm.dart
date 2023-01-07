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

  final List<ui.Image> _faceImages = [];
  List<ui.Image> get faceImages => _faceImages;

  final List<ui.Image> _faceEnhancedImages = [];

  List<ui.Image> get faceEnhancedImages => _faceEnhancedImages;


  Future<void> paintParse() async {
    /// BOX [x, y, width, height]
    if (box.length > 3) {
      ui.Offset realBoxPosition = ui.Offset(box[0].toDouble(), box[1].toDouble());
      ui.Size realBoxSize = ui.Size((box[2]).toDouble(), (box[3]).toDouble());

      for (var enhancedImageBase64 in state.enhancedImages) {
        final faceEnhancedImage = ImageUtils.instance.cropImageBase64(
          enhancedImageBase64.imageBase64,
          size: realBoxSize,
          position: realBoxPosition,
        );
        final faceEnhancedImageUI = await ImageUtils.instance.base64ToImageUI(await faceEnhancedImage);
        _faceEnhancedImages.add(faceEnhancedImageUI);

        double ratioX = state.imageUI.width / enhancedImageBase64.imageUI!.width;
        double ratioY = state.imageUI.height / enhancedImageBase64.imageUI!.height;

        Debug.log(ratioX);
        Debug.log(ratioY);

        final faceImage = ImageUtils.instance.cropImageBase64(
          state.imageBase64,
          size: Size(realBoxSize.width * ratioX, realBoxSize.height * ratioY),
          position: Offset(realBoxPosition.dx * ratioX, realBoxPosition.dy * ratioY),
        );
        final faceImageUI = await ImageUtils.instance.base64ToImageUI(await faceImage);
        _faceImages.add(faceImageUI);
      }
    }
  }

  onSelect() async {
    state.paintBefore.background = _faceImages[state.enhancedImageIndex].backgroundDrawable;
    state.paintAfter.background = _faceEnhancedImages[state.enhancedImageIndex].backgroundDrawable;
    state.paintSize = ui.Size(_faceImages[state.enhancedImageIndex].width.toDouble(), _faceImages[state.enhancedImageIndex].height.toDouble());
  }
}
