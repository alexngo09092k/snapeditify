import 'dart:convert';
// import 'package:corsac_jwt/corsac_jwt.dart';
import 'end_points.dart';

class SnapEditConfig {
  final String baseUrl;

  final String apiKey;

  final String version;

  final EndPoints endPoints;

  final int maxFreeDownloadCount;

  SnapEditConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.version,
    required this.endPoints,
    required this.maxFreeDownloadCount,
  }) {
    _jwt = _buildJWT();
  }

  late String _jwt;
  String get jwt => _jwt;

  factory SnapEditConfig.defaultValue() {
    return SnapEditConfig(
      baseUrl: "https://be-prod-1.snapedit.app/",
      // apiKey: "s2svtF6qSCwBCI0Xjm4MvY0fBGVrtoUCbidhNmkvrJA=",
      apiKey: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ2ZXJzaW9uIjoiMy4xLjAiLCJleHAiOjE3Njk2MjI0MDEsInN1YiI6Imlnbm9yZSIsInBsYXRmb3JtIjoiYW5kcm9pZCJ9.OufJuEzKvN2RVCw-Ofy1oY6d9oRuOnM_Vxmt6aqLWAk",
      version: "4.6.3",
      maxFreeDownloadCount: 100,
      endPoints: EndPoints.defaultValue(),
    );
  }

  SnapEditConfig copyWith({
    String? baseUrl,
    String? apiKey,
    String? version,
    EndPoints? endPoints,
    int? maxFreeDownloadCount,
  }) {
    return SnapEditConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      apiKey: apiKey ?? this.apiKey,
      version: version ?? this.version,
      endPoints: endPoints ?? this.endPoints,
      maxFreeDownloadCount: maxFreeDownloadCount ?? this.maxFreeDownloadCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseUrl': baseUrl,
      'apiKey': apiKey,
      'version': version,
      'endPoints': endPoints.toMap(),
      'maxFreeDownloadCount': maxFreeDownloadCount,
    };
  }

  factory SnapEditConfig.fromMap(Map<String, dynamic> map) {
    return SnapEditConfig.defaultValue().copyWith(
      baseUrl: map['baseUrl'],
      apiKey: map['apiKey'],
      version: map['version'],
      endPoints: map['endPoints'] != null ? EndPoints.fromMap(map['endPoints']) : null,
      maxFreeDownloadCount: map['maxFreeDownloadCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SnapEditConfig.fromJson(String source) => SnapEditConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SnapEditConfig(baseUrl: $baseUrl, apiKey: $apiKey, version: $version, endPoints: $endPoints, maxFreeDownloadCount: $maxFreeDownloadCount)';
  }

  @override
  bool operator ==(covariant SnapEditConfig other) {
    if (identical(this, other)) return true;

    return other.baseUrl == baseUrl &&
        other.apiKey == apiKey &&
        other.version == version &&
        other.endPoints == endPoints &&
        other.maxFreeDownloadCount == maxFreeDownloadCount;
  }

  @override
  int get hashCode {
    return baseUrl.hashCode ^
        apiKey.hashCode ^
        version.hashCode ^
        endPoints.hashCode ^
        maxFreeDownloadCount.hashCode;
  }
}

extension HeaderBuilders on SnapEditConfig {
  Map<String, String> get headers => {
        "User-Agent": "SnapEdit/$version (com.sfun.snapedit; build:155; iOS 15.6.1) Alamofire/5.6.2",
        "Authorization": "Bearer $jwt",
      };
}

extension JWTBuilders on SnapEditConfig {
  String _buildJWT() {
    return apiKey;
    // final JWTBuilder builder = JWTBuilder();
    // builder.subject = 'ignore';
    // builder.expiresAt = DateTime.now().add(const Duration(minutes: 3));
    // builder.setClaim('platform', 'android');
    // builder.setClaim('version', version);
    // final JWT jwt = builder.getSignedToken(JWTHmacSha256Signer(base64UrlEncode(base64.decode(apiKey))));
    // return jwt.toString();
  }
}
