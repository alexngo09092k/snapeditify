// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:qr_scanner/models/qr_data_type.dart';
import 'package:qr_scanner/models/qr_type.dart';

class QRData {
  final String qrData;
  final QRType qrType;
  final QRDataType type;
  DateTime lastModified;
  final Uint8List? image;

  QRData({
    required this.qrData,
    required this.qrType,
    required this.type,
    required this.lastModified,
    this.image,
  });

  QRData copyWith({
    String? qrData,
    QRType? qrType,
    QRDataType? type,
    DateTime? lastModified,
    Uint8List? image,
  }) {
    return QRData(
      qrData: qrData ?? this.qrData,
      qrType: qrType ?? this.qrType,
      type: type ?? this.type,
      lastModified: lastModified ?? this.lastModified,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qrData': qrData,
      'qrType': qrType.name,
      'type': type.name,
      'lastModified': lastModified.millisecondsSinceEpoch,
      'image': image?.toList(),
    };
  }

  factory QRData.fromMap(Map<String, dynamic> map) {
    return QRData(
      qrData: map['qrData'] as String,
      qrType: QRType.values.firstWhere((element) => element.name == map['qrType']),
      type: QRDataType.values.firstWhere((element) => element.name == map['type']),
      lastModified: DateTime.fromMillisecondsSinceEpoch(map['lastModified'] as int),
      image:map['image'] != null? Uint8List.fromList(map['image']): null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QRData.fromJson(String source) => QRData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QRData(qrData: $qrData, qrType: $qrType, type: $type, lastModified: $lastModified, image: $image)';
  }

  @override
  bool operator ==(covariant QRData other) {
    if (identical(this, other)) return true;
  
    return 
      other.qrData == qrData &&
      other.qrType == qrType &&
      other.type == type &&
      other.lastModified == lastModified &&
      other.image == image;
  }

  @override
  int get hashCode {
    return qrData.hashCode ^
      qrType.hashCode ^
      type.hashCode ^
      lastModified.hashCode ^
      image.hashCode;
  }
}
