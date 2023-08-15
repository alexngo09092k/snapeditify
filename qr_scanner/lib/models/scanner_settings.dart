// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerSettings {
  CameraFacing facing;
  DetectionSpeed detectionSpeed;
  int detectionTimeoutMs;
  bool torchEnabled;
  List<BarcodeFormat> formats = [];
  bool returnImage = true;
  bool autoStart = true;

  ScannerSettings({
    this.facing = CameraFacing.back,
    this.detectionSpeed = DetectionSpeed.normal,
    this.detectionTimeoutMs = 250,
    this.torchEnabled = false,
    this.formats = BarcodeFormat.values,
    this.returnImage = true,
    this.autoStart = true,
  });

  ScannerSettings copyWith({
    CameraFacing? facing,
    DetectionSpeed? detectionSpeed,
    int? detectionTimeoutMs,
    bool? torchEnabled,
    List<BarcodeFormat>? formats,
    bool? returnImage,
    bool? autoStart,
  }) {
    return ScannerSettings(
      facing: facing ?? this.facing,
      detectionSpeed: detectionSpeed ?? this.detectionSpeed,
      detectionTimeoutMs: detectionTimeoutMs ?? this.detectionTimeoutMs,
      torchEnabled: torchEnabled ?? this.torchEnabled,
      formats: formats ?? this.formats,
      returnImage: returnImage ?? this.returnImage,
      autoStart: autoStart ?? this.autoStart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'facing': facing.name,
      'detectionSpeed': detectionSpeed.name,
      'detectionTimeoutMs': detectionTimeoutMs,
      'torchEnabled': torchEnabled,
      'formats': formats.map((x) => x.name).toList(),
      'returnImage': returnImage,
      'autoStart': autoStart,
    };
  }

  factory ScannerSettings.fromMap(Map<String, dynamic> map) {
    return ScannerSettings().copyWith(
      facing: CameraFacing.values.firstWhere((element) => element.name == map['facing'], orElse: () => CameraFacing.back),
      detectionSpeed: DetectionSpeed.values.firstWhere((element) => element.name == map['detectionSpeed'], orElse: () => DetectionSpeed.normal),
      detectionTimeoutMs: map['detectionTimeoutMs'],
      torchEnabled: map['torchEnabled'],
      formats: map['formats']?.map<BarcodeFormat>((element) => BarcodeFormat.values.firstWhere((i) => element == i.name, orElse: () => BarcodeFormat.all),).toList(),
      returnImage: map['returnImage'],
      autoStart: map['autoStart'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScannerSettings.fromJson(String source) => ScannerSettings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScannerSettings(facing: $facing, detectionSpeed: $detectionSpeed, detectionTimeoutMs: $detectionTimeoutMs, torchEnabled: $torchEnabled, formats: $formats, returnImage: $returnImage, autoStart: $autoStart)';
  }

  @override
  bool operator ==(covariant ScannerSettings other) {
    if (identical(this, other)) return true;

    return other.facing == facing &&
        other.detectionSpeed == detectionSpeed &&
        other.detectionTimeoutMs == detectionTimeoutMs &&
        other.torchEnabled == torchEnabled &&
        listEquals(other.formats, formats) &&
        other.returnImage == returnImage &&
        other.autoStart == autoStart;
  }

  @override
  int get hashCode {
    return facing.hashCode ^
        detectionSpeed.hashCode ^
        detectionTimeoutMs.hashCode ^
        torchEnabled.hashCode ^
        formats.hashCode ^
        returnImage.hashCode ^
        autoStart.hashCode;
  }
}
