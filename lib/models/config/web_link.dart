import 'dart:convert';

class WebLink {
  final String link;
  final String title;
  final String image;

  WebLink({
    required this.link,
    required this.title,
    required this.image,
  });

  WebLink copyWith({
    String? link,
    String? title,
    String? image,
  }) {
    return WebLink(
      link: link ?? this.link,
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link': link,
      'title': title,
      'image': image,
    };
  }

  factory WebLink.fromMap(Map<String, dynamic> map) {
    return WebLink(
      link: map['link'],
      title: map['title'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WebLink.fromJson(String source) => WebLink.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WebLink(link: $link, title: $title, image: $image)';

  @override
  bool operator ==(covariant WebLink other) {
    if (identical(this, other)) return true;

    return other.link == link && other.title == title && other.image == image;
  }

  @override
  int get hashCode => link.hashCode ^ title.hashCode ^ image.hashCode;
}
