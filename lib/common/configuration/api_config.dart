part of '../configuration.dart';

class ApiConfig {
  String url;
  String eraseEndPoint;
  String aiEndPoint;

  ApiConfig({
    required this.url,
    required this.eraseEndPoint,
    required this.aiEndPoint,
  });

  ApiConfig copyWith({
    String? url,
    String? eraseEndPoint,
    String? aiEndPoint,
  }) {
    return ApiConfig(
      url: url ?? this.url,
      eraseEndPoint: eraseEndPoint ?? this.eraseEndPoint,
      aiEndPoint: aiEndPoint ?? this.aiEndPoint,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'eraseEndPoint': eraseEndPoint,
      'aiEndPoint': aiEndPoint,
    };
  }

  factory ApiConfig.fromMap(Map<String, dynamic> map) {
    return ApiConfig(
      url: map['url'] ?? '',
      eraseEndPoint: map['eraseEndPoint'] ?? '',
      aiEndPoint: map['aiEndPoint'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiConfig.fromJson(String source) => ApiConfig.fromMap(json.decode(source));

  @override
  String toString() =>
      'ApiConfig(url: $url, eraseEndPoint: $eraseEndPoint, aiEndPoint: $aiEndPoint)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiConfig &&
        other.url == url &&
        other.eraseEndPoint == eraseEndPoint &&
        other.aiEndPoint == aiEndPoint;
  }

  @override
  int get hashCode =>
      url.hashCode ^ eraseEndPoint.hashCode ^ aiEndPoint.hashCode;
}
