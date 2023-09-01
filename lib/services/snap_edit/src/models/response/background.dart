// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Background {
  final String category;
  final String name;
  final String thumbnailUrl;
  final String url;

  const Background({
    required this.category,
    required this.name,
    required this.thumbnailUrl,
    required this.url,
  });

  Background copyWith({
    String? category,
    String? name,
    String? thumbnailUrl,
    String? url,
  }) {
    return Background(
      category: category ?? this.category,
      name: name ?? this.name,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'name': name,
      'thumbnail_url': thumbnailUrl,
      'url': url,
    };
  }

  factory Background.fromMap(Map<String, dynamic> map) {
    return Background(
      category: map['category'] as String,
      name: map['name'] as String,
      thumbnailUrl: map['thumbnail_url'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Background.fromJson(String source) => Background.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Background(category: $category, name: $name, thumbnail_url: $thumbnailUrl, url: $url)';
  }

  @override
  bool operator ==(covariant Background other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.name == name &&
        other.thumbnailUrl == thumbnailUrl &&
        other.url == url;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        name.hashCode ^
        thumbnailUrl.hashCode ^
        url.hashCode;
  }
}
