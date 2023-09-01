import 'dart:convert';

import 'package:snapeditify/services/snap_edit/src/models/config/dimension.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RestyleConfig {
  /// Free dimension
  final Dimension dimension;

  RestyleConfig({
    required this.dimension,
  });

  factory RestyleConfig.defaultValue() {
    return RestyleConfig(dimension: Dimension.defaultValue());
  }

  RestyleConfig copyWith({
    Dimension? dimension,
  }) {
    return RestyleConfig(
      dimension: dimension ?? this.dimension,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dimension': dimension.toMap(),
    };
  }

  factory RestyleConfig.fromMap(Map<String, dynamic> map) {
    return RestyleConfig.defaultValue().copyWith(
      dimension: map['dimension'] != null ? Dimension.fromMap(map['dimension']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestyleConfig.fromJson(String source) => RestyleConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RestyleConfig(dimension: $dimension)';

  @override
  bool operator ==(covariant RestyleConfig other) {
    if (identical(this, other)) return true;

    return other.dimension == dimension;
  }

  @override
  int get hashCode => dimension.hashCode;
}
