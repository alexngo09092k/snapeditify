import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:snapeditify/services/snap_edit/src/models/response/effect.dart';

class RestyleEffectsResponse {
  final List<Effect> styles;

  const RestyleEffectsResponse({
    required this.styles,
  });

  RestyleEffectsResponse copyWith({
    List<Effect>? styles,
  }) {
    return RestyleEffectsResponse(
      styles: styles ?? this.styles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'styles': styles.map((x) => x.toMap()).toList(),
    };
  }

  factory RestyleEffectsResponse.fromMap(Map<String, dynamic> map) {
    return RestyleEffectsResponse(
      styles: List<Effect>.from((map['styles'] ?? []).map<Effect>((x) => Effect.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RestyleEffectsResponse.fromJson(String source) {
    return RestyleEffectsResponse.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() => 'RestyleEffectsResponse(styles: $styles)';

  @override
  bool operator ==(covariant RestyleEffectsResponse other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.styles, styles);
  }

  @override
  int get hashCode => styles.hashCode;
}
