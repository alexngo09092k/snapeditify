// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';
import 'package:qr_scanner/models/qr_source.dart';
import 'package:qr_scanner/models/qr_type.dart';

class QR {
  final String rawData;
  final QRType type;
  final QRSource source;
  DateTime lastModified;

  QR({
    required this.rawData,
    required this.type,
    required this.source,
    required this.lastModified,
  });

  QR copyWith({
    String? rawData,
    QRType? type,
    QRSource? source,
    DateTime? lastModified,
    Uint8List? image,
  }) {
    return QR(
      rawData: rawData ?? this.rawData,
      type: type ?? this.type,
      source: source ?? this.source,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rawData': rawData,
      'type': type.name,
      'source': source.name,
      'lastModified': lastModified.millisecondsSinceEpoch,
    };
  }

  factory QR.fromMap(Map<String, dynamic> map) {
    return QR(
      rawData: map['rawData'] as String,
      type: QRType.values.firstWhere((element) => element.name == map['type']),
      source: QRSource.values.firstWhere((element) => element.name == map['source']),
      lastModified: DateTime.fromMillisecondsSinceEpoch(map['lastModified'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory QR.fromJson(String source) => QR.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QR(rawData: $rawData, type: $type, source: $source, lastModified: $lastModified)';
  }

  @override
  bool operator ==(covariant QR other) {
    if (identical(this, other)) return true;
  
    return 
      other.rawData == rawData &&
      other.type == type &&
      other.source == source &&
      other.lastModified == lastModified;
  }

  @override
  int get hashCode {
    return rawData.hashCode ^
      type.hashCode ^
      source.hashCode ^
      lastModified.hashCode;
  }
}
