import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/utils/image_convert.dart';
import 'package:snapedit/modules/painter/painter.dart';

class DetectedObject {
  final List<int> box;
  final DetectedObjectType objectType;
  final String mask;
  final double accuracy;
  final String objectDescription;
  final int maskId;

  ImageDrawable? maskDrawable;
  RectangleDrawable? boxDrawble;
  String? image;

  bool isRemoved = false;
  bool isSelected = false;

  DetectedObject({
    required this.box,
    required this.objectType,
    required this.mask,
    required this.accuracy,
    required this.objectDescription,
    required this.maskId,
  });

  DetectedObject copyWith({
    List<int>? box,
    DetectedObjectType? objectType,
    String? mask,
    double? accuracy,
    String? objectDescription,
    int? maskId,
    Function(ui.Offset)? onTap,
    ImageDrawable? maskDrawable,
    RectangleDrawable? boxDrawble,
    String? image,
    bool? isRemoved,
    bool? isSelected,
  }) {
    return DetectedObject(
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

  Map<String, dynamic> toMap() {
    return {
      'box': box,
      'object_type': objectType.value,
      'mask': mask,
      'accuracy': accuracy,
      'object_description': objectDescription,
      'mask_id': maskId,
    };
  }

  factory DetectedObject.fromMap(Map<String, dynamic> map) {
    return DetectedObject(
      box: List<int>.from(map['box']),
      objectType: DetectedObjectTypeExtension.fromValue(map['object_type']),
      mask: map['mask'] ?? '',
      accuracy: double.parse(map['accuracy']),
      objectDescription: map['object_description'] ?? '',
      maskId: map['mask_id']?.toInt() ?? 0,
    );
  }

  Future<void> paintParse({
    required ui.Size realSize,
    required ui.Size viewSize,
    required String originalImageBase64,
    Function(ui.Offset)? onTap,
  }) async {
    ui.Offset realBoxPosition = ui.Offset(box[0].toDouble(), box[1].toDouble());
    ui.Size realBoxSize =
        ui.Size((box[2] - box[0]).toDouble(), (box[3] - box[1]).toDouble());

    double ratioX = viewSize.width / realSize.width;
    double ratioY = viewSize.height / realSize.height;

    ui.Size size =
        ui.Size(realBoxSize.width * ratioX, realBoxSize.height * ratioY);
    ui.Offset position = ui.Offset(
      realBoxPosition.dx * ratioX + size.width / 2,
      realBoxPosition.dy * ratioX + size.height / 2,
    );

    printLog('paintParse $position');
    printLog('paintParse $size');

    if (box.length > 3) {
      var paint = Paint()
        ..strokeWidth = 0.5
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      maskDrawable = ImageDrawable.fittedToSize(
        position: position,
        size: size,
        image: await ImageConvert.base64ToImage(mask),
        locked: true,
        onTap: onTap,
      );

      boxDrawble = RectangleDrawable(
        paint: paint,
        position: position,
        size: size,
        locked: true,
      );

      image = await ImageConvert.cropImageString(
        imageBase64: originalImageBase64,
        size: realBoxSize,
        position: realBoxPosition,
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory DetectedObject.fromJson(String source) =>
      DetectedObject.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DetectedObject(box: $box, objectType: $objectType, mask: $mask, accuracy: $accuracy, objectDescription: $objectDescription, maskId: $maskId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DetectedObject &&
        listEquals(other.box, box) &&
        other.objectType == objectType &&
        other.mask == mask &&
        other.accuracy == accuracy &&
        other.objectDescription == objectDescription &&
        other.maskId == maskId;
  }

  @override
  int get hashCode {
    return box.hashCode ^
        objectType.hashCode ^
        mask.hashCode ^
        accuracy.hashCode ^
        objectDescription.hashCode ^
        maskId.hashCode;
  }
}

enum DetectedObjectType {
  other,
  people,
}

extension DetectedObjectTypeExtension on DetectedObjectType {
  String get value {
    switch (this) {
      case DetectedObjectType.other:
        return 'other';
      case DetectedObjectType.people:
        return 'person';
      default:
        return 'other';
    }
  }

  String get name {
    switch (this) {
      case DetectedObjectType.other:
        return 'Others';
      case DetectedObjectType.people:
        return 'People';
      default:
        return 'Others';
    }
  }

  static DetectedObjectType fromValue(String value) {
    switch (value) {
      case 'other':
        return DetectedObjectType.other;
      case 'person':
        return DetectedObjectType.people;
      default:
        return DetectedObjectType.other;
    }
  }
}
