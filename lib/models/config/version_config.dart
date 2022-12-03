import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VersionConfig {
  /// MAX VERSION SHOW
  final String maxVersionShow;

  /// MESSAGE
  final String message;

  /// STATUS
  final int status;

  /// TITLE
  final String title;

  /// URL UPDATE
  final String url;

  VersionConfig({
    required this.maxVersionShow,
    required this.message,
    required this.status,
    required this.title,
    required this.url,
  });

  VersionConfig copyWith({
    String? maxVersionShow,
    String? message,
    int? status,
    String? title,
    String? url,
  }) {
    return VersionConfig(
      maxVersionShow: maxVersionShow ?? this.maxVersionShow,
      message: message ?? this.message,
      status: status ?? this.status,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maxVersionShow': maxVersionShow,
      'message': message,
      'status': status,
      'title': title,
      'url': url,
    };
  }

  factory VersionConfig.fromMap(Map<String, dynamic> map) {
    return VersionConfig(
      maxVersionShow: map['maxVersionShow'] as String,
      message: map['message'] as String,
      status: map['status'] as int,
      title: map['title'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VersionConfig.fromJson(String source) => VersionConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VersionConfig(maxVersionShow: $maxVersionShow, message: $message, status: $status, title: $title, url: $url)';
  }

  @override
  bool operator ==(covariant VersionConfig other) {
    if (identical(this, other)) return true;

    return other.maxVersionShow == maxVersionShow && other.message == message && other.status == status && other.title == title && other.url == url;
  }

  @override
  int get hashCode {
    return maxVersionShow.hashCode ^ message.hashCode ^ status.hashCode ^ title.hashCode ^ url.hashCode;
  }
}
