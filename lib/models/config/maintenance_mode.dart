
import 'dart:convert';

class MaintenanceMode {
  final String title;
  final String message;
  final String link;

  const MaintenanceMode({
    required this.title,
    required this.message,
    required this.link,
  });

  MaintenanceMode copyWith({
    String? title,
    String? message,
    String? link,
  }) {
    return MaintenanceMode(
      title: title ?? this.title,
      message: message ?? this.message,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'link': link,
    };
  }

  factory MaintenanceMode.fromMap(Map<String, dynamic> map) {
    return MaintenanceMode(
      title: map['title'] as String,
      message: map['message'] as String,
      link: map['link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintenanceMode.fromJson(String source) => MaintenanceMode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MaintenanceMode(title: $title, message: $message, link: $link)';

  @override
  bool operator ==(covariant MaintenanceMode other) {
    if (identical(this, other)) return true;

    return other.title == title && other.message == message && other.link == link;
  }

  @override
  int get hashCode => title.hashCode ^ message.hashCode ^ link.hashCode;
}