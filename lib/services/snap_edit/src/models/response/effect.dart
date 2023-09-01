import 'dart:convert';

class Effect {
  final String category;
  final bool premium;
  final String name;
  final String styleId;
  final String thumbnailUrl;

  const Effect({
    this.category = "",
    this.premium = false,
    required this.name,
    required this.styleId,
    required this.thumbnailUrl,
  });

  Effect copyWith({
    String? category,
    bool? premium,
    String? name,
    String? styleId,
    String? thumbnailUrl,
  }) {
    return Effect(
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

  factory Effect.fromMap(Map<String, dynamic> map) {
    return Effect(
      category: map['category'] ?? '',
      premium: map['premium'] ?? false,
      name: map['name'],
      styleId: map['style_id'],
      thumbnailUrl: map['thumbnail_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Effect.fromJson(String source) => Effect.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Effect(category: $category, premium: $premium, name: $name, styleId: $styleId, thumbnailUrl: $thumbnailUrl)';
  }

  @override
  bool operator ==(covariant Effect other) {
    if (identical(this, other)) return true;
  
    return 
      other.category == category &&
      other.premium == premium &&
      other.name == name &&
      other.styleId == styleId &&
      other.thumbnailUrl == thumbnailUrl;
  }

  @override
  int get hashCode {
    return category.hashCode ^
      premium.hashCode ^
      name.hashCode ^
      styleId.hashCode ^
      thumbnailUrl.hashCode;
  }
}
