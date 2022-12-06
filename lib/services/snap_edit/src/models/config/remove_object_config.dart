import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RemoveObjectConfig {
  /// high demension
  final int highDimension;

  /// pro dimension
  final int proDimension;

  /// save image local
  final bool saveImageLocal;

  /// standard demension
  final int standardDimension;

  RemoveObjectConfig({
    required this.highDimension,
    required this.proDimension,
    required this.saveImageLocal,
    required this.standardDimension,
  });

  factory RemoveObjectConfig.defaultValue() {
    return RemoveObjectConfig(
      highDimension: 1920,
      proDimension: 3000,
      saveImageLocal: false,
      standardDimension: 1200,
    );
  }

  RemoveObjectConfig copyWith({
    int? highDimension,
    int? proDimension,
    bool? saveImageLocal,
    int? standardDimension,
  }) {
    return RemoveObjectConfig(
      highDimension: highDimension ?? this.highDimension,
      proDimension: proDimension ?? this.proDimension,
      saveImageLocal: saveImageLocal ?? this.saveImageLocal,
      standardDimension: standardDimension ?? this.standardDimension,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'highDimension': highDimension,
      'proDimension': proDimension,
      'saveImageLocal': saveImageLocal,
      'standardDimension': standardDimension,
    };
  }

  factory RemoveObjectConfig.fromMap(Map<String, dynamic> map) {
    return RemoveObjectConfig.defaultValue().copyWith(
      highDimension: map['highDimension'],
      proDimension: map['proDimension'],
      saveImageLocal: map['saveImageLocal'],
      standardDimension: map['standardDimension'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoveObjectConfig.fromJson(String source) => RemoveObjectConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RemoveObjectConfig(highDimension: $highDimension, proDimension: $proDimension, saveImageLocal: $saveImageLocal, standardDimension: $standardDimension)';
  }

  @override
  bool operator ==(covariant RemoveObjectConfig other) {
    if (identical(this, other)) return true;

    return other.highDimension == highDimension &&
        other.proDimension == proDimension &&
        other.saveImageLocal == saveImageLocal &&
        other.standardDimension == standardDimension;
  }

  @override
  int get hashCode {
    return highDimension.hashCode ^ proDimension.hashCode ^ saveImageLocal.hashCode ^ standardDimension.hashCode;
  }
}
