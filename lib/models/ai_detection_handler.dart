import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';
import 'package:snapedit/utils/image.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';
import 'package:snapedit/widgets/painter/painter.dart';
import 'dart:ui' as ui;

class AIDetectionHandler extends AIDetectionResponse {
  AIDetectionHandler({
    required super.detectedObjects,
    required super.eventId,
    required super.sessionId,
  }) {
    _initial();
  }

  factory AIDetectionHandler.defaultValue() {
    return AIDetectionHandler(detectedObjects: [], eventId: '', sessionId: '');
  }

  factory AIDetectionHandler.fromAIDetectionResponse(AIDetectionResponse response) {
    return AIDetectionHandler(
      detectedObjects: response.detectedObjects,
      eventId: response.eventId,
      sessionId: response.sessionId,
    );
  }

  late final List<DetectedObjectHandler> _detectedObjectsHandler;
  List<DetectedObjectHandler> get detectedObjectsHandler => _detectedObjectsHandler;

  Future<void> _initial() async {
    _detectedObjectsHandler = detectedObjects.map((e) => DetectedObjectHandler.fromDetectedObject(e)).toList();
  }
}

class DetectedObjectHandler extends DetectedObject {
  DetectedObjectHandler({
    required super.accuracy,
    required super.box,
    required super.mask,
    required super.maskId,
    required super.objectDescription,
    required super.objectType,
  });

  ImageDrawable? maskDrawable;
  RectangleDrawable? boxDrawble;
  String? image;

  bool isRemoved = false;
  bool isSelected = false;

  Function()? onMaskTap;
  Function()? onBoxTap;

  factory DetectedObjectHandler.fromDetectedObject(DetectedObject detectedObject) {
    return DetectedObjectHandler(
      accuracy: detectedObject.accuracy,
      box: detectedObject.box,
      mask: detectedObject.mask,
      maskId: detectedObject.maskId,
      objectDescription: detectedObject.objectDescription,
      objectType: detectedObject.objectType,
    );
  }

  @override
  DetectedObjectHandler copyWith({
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
  }) {
    return DetectedObjectHandler(
      box: box ?? this.box,
      objectType: objectType ?? this.objectType,
      mask: mask ?? this.mask,
      accuracy: accuracy ?? this.accuracy,
      objectDescription: objectDescription ?? this.objectDescription,
      maskId: maskId ?? this.maskId,
    )
      ..maskDrawable = maskDrawable ?? this.maskDrawable
      ..boxDrawble = boxDrawble ?? this.boxDrawble
      ..image = image ?? this.image
      ..isRemoved = isRemoved ?? this.isRemoved
      ..isSelected = isSelected ?? this.isSelected;
  }

  Future<void> paintParse({
    required ui.Size realSize,
    required ui.Size viewSize,
    required String originalImageBase64,
    Function()? onMaskTap,
    Function()? onBoxTap,
  }) async {
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

      this.onMaskTap = onMaskTap;
      maskDrawable = ImageDrawable.fittedToSize(
        position: position,
        size: size,
        image: await ImageUtils.instance.base64ToImageUI(mask),
        locked: true,
        onTap: (_) => this.onMaskTap!(),
        opacity: 0.2,
      );

      this.onBoxTap = onBoxTap;
      boxDrawble = RectangleDrawable(
        paint: paint,
        position: position,
        size: size,
        locked: true,
        onTap: (_) => this.onBoxTap!(),
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
