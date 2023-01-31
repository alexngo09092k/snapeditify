import 'dart:convert';
import 'dimension.dart';
import 'stroke_width.dart';

class RemoveObjectConfig {
  final Dimension dimension;
  final StrokeWidth strokeWidth;

  const RemoveObjectConfig({
    required this.dimension,
    required this.strokeWidth,
  });

  factory RemoveObjectConfig.defaultValue() {
    return RemoveObjectConfig(
      dimension: Dimension.defaultValue(),
      strokeWidth: StrokeWidth.defaultValue(),
    );
  }

  RemoveObjectConfig copyWith({
    Dimension? dimension,
    StrokeWidth? strokeWidth,
  }) {
    return RemoveObjectConfig(
      dimension: dimension ?? this.dimension,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dimension': dimension.toMap(),
      'strokeWidth': strokeWidth.toMap(),
    };
  }

  factory RemoveObjectConfig.fromMap(Map<String, dynamic> map) {
    return RemoveObjectConfig.defaultValue().copyWith(
      dimension: map['dimension'] != null ? Dimension.fromMap(map['dimension']) : null,
      strokeWidth: map['strokeWidth'] != null ? StrokeWidth.fromMap(map['strokeWidth']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoveObjectConfig.fromJson(String source) => RemoveObjectConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RemoveObjectConfig(dimension: $dimension, strokeWidth: $strokeWidth)';

  @override
  bool operator ==(covariant RemoveObjectConfig other) {
    if (identical(this, other)) return true;

    return other.dimension == dimension && other.strokeWidth == strokeWidth;
  }

  @override
  int get hashCode => dimension.hashCode ^ strokeWidth.hashCode;
}
