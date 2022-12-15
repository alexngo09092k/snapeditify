import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/providers/remove_object/remove_object_state.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';
import 'package:snapedit/utils/image.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';
import 'package:snapedit/widgets/painter/painter.dart';
import 'dart:ui' as ui;

class DetectedObjectVM extends DetectedObject with Provider {
  DetectedObjectVM({
    required super.accuracy,
    required super.box,
    required super.mask,
    required super.maskId,
    required super.objectDescription,
    required super.objectType,
    required this.state,
  });

  ImageDrawable? maskDrawable;
  RectangleDrawable? boxDrawble;
  String? image;

  bool _isRemoved = false;
  bool get isRemoved => _isRemoved;
  set isRemoved(bool value) {
    if (_isRemoved != value) {
      _isRemoved = value;
      notifyListeners();
    }
  }

  bool _isSelected = false;
  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    if (_isSelected != value) {
      _isSelected = value;
      notifyListeners();
    }
  }

  RemoveObjectState state;

  factory DetectedObjectVM.fromDetectedObject(DetectedObject detectedObject, RemoveObjectState state) {
    return DetectedObjectVM(
      accuracy: detectedObject.accuracy,
      box: detectedObject.box,
      mask: detectedObject.mask,
      maskId: detectedObject.maskId,
      objectDescription: detectedObject.objectDescription,
      objectType: detectedObject.objectType,
      state: state,
    );
  }

  @override
  DetectedObjectVM copyWith({
    List<int>? box,
    DetectedObjectType? objectType,
    String? mask,
    String? accuracy,
    String? objectDescription,
    int? maskId,
    Function(ui.Offset)? onTap,
    ImageDrawable? maskDrawable,
    RectangleDrawable? boxDrawble,
    String? image,
    bool? isRemoved,
    bool? isSelected,
    RemoveObjectState? state,
  }) {
    final other = DetectedObjectVM(
      box: box ?? this.box,
      objectType: objectType ?? this.objectType,
      mask: mask ?? this.mask,
      accuracy: accuracy ?? this.accuracy,
      objectDescription: objectDescription ?? this.objectDescription,
      maskId: maskId ?? this.maskId,
      state: state ?? this.state,
    )
      ..image = image ?? this.image
      ..isRemoved = isRemoved ?? this.isRemoved
      ..isSelected = isSelected ?? this.isSelected;

    other.maskDrawable = maskDrawable ?? this.maskDrawable?.copyWith(onTap: (_) => other._removeMask());
    other.boxDrawble = boxDrawble ?? this.boxDrawble?.copyWith(onTap: (_) => other._addMask());

    return other;
  }

  _removeMask() {
    if (maskDrawable != null) {
      state.paint.removeDrawable(maskDrawable!, saveAction: false);
      isSelected = false;
    }
  }

  _addMask() {
    if (maskDrawable != null) {
      state.paint.addDrawables([maskDrawable!], saveAction: false);
      isSelected = true;
    }
  }

  toggleSelection() {
    if (isRemoved) return;
    if (isSelected) {
      _removeMask();
    } else {
      _addMask();
    }
  }

  Future<void> paintParse() async {
    final renderBox = state.paint.painterKey.currentContext?.findRenderObject() as RenderBox?;
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

      var paint = Paint()
        ..strokeWidth = 0.5
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      maskDrawable = ImageDrawable.fittedToSize(
        position: position,
        size: size,
        image: await ImageUtils.instance.base64ToImageUI(mask),
        locked: true,
        onTap: (_) => _removeMask(),
        opacity: 0.2,
      );

      boxDrawble = RectangleDrawable(
        paint: paint,
        position: position,
        size: size,
        locked: true,
        onTap: (_) => _addMask(),
      );

      image = await ImageUtils.instance.cropImageBase64(
        originalImageBase64,
        size: realBoxSize,
        position: realBoxPosition,
      );
    }
  }
}

extension DetectedObjectTypeExtension on DetectedObjectType {
  String get label {
    switch (this) {
      case DetectedObjectType.other:
        return 'Others';
      case DetectedObjectType.person:
        return 'People';
      default:
        return 'Others';
    }
  }
}
