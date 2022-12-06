import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StylesResponse {
  final List<Style> styles;

  StylesResponse({
    required this.styles,
  });

  factory StylesResponse.defaultValue() {
    return StylesResponse(styles: []);
  }

  StylesResponse copyWith({
    List<Style>? styles,
  }) {
    return StylesResponse(
      styles: styles ?? this.styles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'styles': styles.map((x) => x.toMap()).toList(),
    };
  }

  factory StylesResponse.fromMap(Map<String, dynamic> map) {
    return StylesResponse.defaultValue().copyWith(
      styles: List<Style>.from(
        (map['styles'] ?? []).map<Style>(
          (x) => Style.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StylesResponse.fromJson(String source) => StylesResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StylesResponse(styles: $styles)';

  @override
  bool operator ==(covariant StylesResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.styles, styles);
  }

  @override
  int get hashCode => styles.hashCode;
}

class Style {
  final String name;
  final String styleId;
  final String thumbnailUrl;

  Style({
    required this.name,
    required this.styleId,
    required this.thumbnailUrl,
  });

  factory Style.defaultValue() {
    return Style(
      name: '',
      styleId: '',
      thumbnailUrl: '',
    );
  }

  Style copyWith({
    String? name,
    String? styleId,
    String? thumbnailUrl,
  }) {
    return Style(
      name: name ?? this.name,
      styleId: styleId ?? this.styleId,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'style_id': styleId,
      'thumbnail_url': thumbnailUrl,
    };
  }

  factory Style.fromMap(Map<String, dynamic> map) {
    return Style.defaultValue().copyWith(
      name: map['name'],
      styleId: map['style_id'],
      thumbnailUrl: map['thumbnail_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Style.fromJson(String source) => Style.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Style(name: $name, styleId: $styleId, thumbnailUrl: $thumbnailUrl)';

  @override
  bool operator ==(covariant Style other) {
    if (identical(this, other)) return true;

    return other.name == name && other.styleId == styleId && other.thumbnailUrl == thumbnailUrl;
  }

  @override
  int get hashCode => name.hashCode ^ styleId.hashCode ^ thumbnailUrl.hashCode;
}
