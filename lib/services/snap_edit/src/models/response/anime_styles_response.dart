import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AnimeStylesResponse {
  final List<AnimeStyle> styles;

  AnimeStylesResponse({
    required this.styles,
  });

  factory AnimeStylesResponse.defaultValue() {
    return AnimeStylesResponse(styles: []);
  }

  AnimeStylesResponse copyWith({
    List<AnimeStyle>? styles,
  }) {
    return AnimeStylesResponse(
      styles: styles ?? this.styles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'styles': styles.map((x) => x.toMap()).toList(),
    };
  }

  factory AnimeStylesResponse.fromMap(Map<String, dynamic> map) {
    return AnimeStylesResponse.defaultValue().copyWith(
      styles: List<AnimeStyle>.from(
        (map['styles'] ?? []).map<AnimeStyle>(
          (x) => AnimeStyle.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeStylesResponse.fromJson(String source) => AnimeStylesResponse.fromMap(json.decode(source));

  @override
  String toString() => 'AnimeStylesResponse(styles: $styles)';

  @override
  bool operator ==(covariant AnimeStylesResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.styles, styles);
  }

  @override
  int get hashCode => styles.hashCode;
}

class AnimeStyle {
  final String category;
  final bool premium;
  final String name;
  final String styleId;
  final String thumbnailUrl;

  AnimeStyle({
    required this.category,
    required this.premium,
    required this.name,
    required this.styleId,
    required this.thumbnailUrl,
  });

  AnimeStyle copyWith({
    String? category,
    bool? premium,
    String? name,
    String? styleId,
    String? thumbnailUrl,
  }) {
    return AnimeStyle(
      category: category ?? this.category,
      premium: premium ?? this.premium,
      name: name ?? this.name,
      styleId: styleId ?? this.styleId,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'premium': premium,
      'name': name,
      'style_id': styleId,
      'thumbnail_url': thumbnailUrl,
    };
  }

  factory AnimeStyle.fromMap(Map<String, dynamic> map) {
    return AnimeStyle(
      category: map['category'] as String,
      premium: map['premium'],
      name: map['name'] as String,
      styleId: map['style_id'] as String,
      thumbnailUrl: map['thumbnail_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeStyle.fromJson(String source) => AnimeStyle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnimeStyle(category: $category, premium: $premium, name: $name, styleId: $styleId, thumbnailUrl: $thumbnailUrl)';
  }

  @override
  bool operator ==(covariant AnimeStyle other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.premium == premium &&
        other.name == name &&
        other.styleId == styleId &&
        other.thumbnailUrl == thumbnailUrl;
  }

  @override
  int get hashCode {
    return category.hashCode ^ premium.hashCode ^ name.hashCode ^ styleId.hashCode ^ thumbnailUrl.hashCode;
  }
}
