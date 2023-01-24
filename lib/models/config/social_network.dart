import 'dart:convert';

class SocialNetwork {
  final String link;
  final String brand;
  final String image;

  SocialNetwork({
    required this.link,
    required this.brand,
    required this.image,
  });

  SocialNetwork copyWith({
    String? link,
    String? brand,
    String? image,
  }) {
    return SocialNetwork(
      link: link ?? this.link,
      brand: brand ?? this.brand,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link': link,
      'brand': brand,
      'image': image,
    };
  }

  factory SocialNetwork.fromMap(Map<String, dynamic> map) {
    return SocialNetwork(
      link: map['link'] as String,
      brand: map['brand'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialNetwork.fromJson(String source) => SocialNetwork.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SocialNetwork(link: $link, brand: $brand, image: $image)';

  @override
  bool operator ==(covariant SocialNetwork other) {
    if (identical(this, other)) return true;

    return other.link == link && other.brand == brand && other.image == image;
  }

  @override
  int get hashCode => link.hashCode ^ brand.hashCode ^ image.hashCode;
}
