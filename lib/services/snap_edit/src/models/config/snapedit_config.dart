import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fluttering/fluttering.dart';
import 'end_points.dart';

class SnapEditConfig {
  final String baseUrl;

  /// Không còn dùng Firebase Installations.
  /// JWT được ký local bằng secret web (HS256), giống snapedit.app.
  final String apiKey;

  final String version;

  final EndPoints endPoints;

  final int maxFreeDownloadCount;

  /// Secret web (base64) lấy từ JS snapedit.app — dùng ký JWT HS256.
  /// Uint8Array.from(atob("HBmQJoIurA0HVLyUaCiFlxF+JJc14eHmZNttilecFGQ="), ...)
  // STORE RISK: third-party web secret hardcode may violate ToS and fail review.
  // Replace with your own backend-issued token before multi-store production.
  static const String _jwtSecretB64 = 'HBmQJoIurA0HVLyUaCiFlxF+JJc14eHmZNttilecFGQ=';

  /// JWT sống ~5 phút trên web (exp = now + 300).
  static const int _jwtTtlSeconds = 300;

  SnapEditConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.version,
    required this.endPoints,
    required this.maxFreeDownloadCount,
  }) {
    _jwt = _signJwt();
    _jwtExpiresAt = DateTime.now().add(const Duration(seconds: _jwtTtlSeconds));
  }

  String _jwt = '';
  DateTime? _jwtExpiresAt;
  Future<void>? _refreshing;

  String get jwt {
    // Auto refresh nếu sắp hết hạn
    if (_jwtExpiresAt == null ||
        DateTime.now().isAfter(_jwtExpiresAt!.subtract(const Duration(seconds: 30)))) {
      _jwt = _signJwt();
      _jwtExpiresAt = DateTime.now().add(const Duration(seconds: _jwtTtlSeconds));
    }
    return _jwt;
  }

  bool get isJwtValid {
    if (_jwt.isEmpty || _jwtExpiresAt == null) return false;
    return DateTime.now().isBefore(_jwtExpiresAt!.subtract(const Duration(seconds: 30)));
  }

  factory SnapEditConfig.defaultValue() {
    return SnapEditConfig(
      // Host web — khớp request erase thành công trên browser
      baseUrl: "https://be-prod-1.snapedit.app/",
      apiKey: "", // không dùng hardcode JWT nữa; ký local
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
    return 'SnapEditConfig(baseUrl: $baseUrl, version: $version, endPoints: $endPoints, maxFreeDownloadCount: $maxFreeDownloadCount)';
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

  static String _b64url(List<int> bytes) {
    return base64Url.encode(bytes).replaceAll('=', '');
  }

  /// Ký JWT giống web:
  /// { sub: "ignore", platform: "web", is_pro, is_premium, exp: now+300 }
  /// header: { alg: "HS256", typ: "JWT" }
  String _signJwt({bool isPro = false, bool isPremium = false}) {
    final header = <String, dynamic>{'alg': 'HS256', 'typ': 'JWT'};
    final nowSec = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final payload = <String, dynamic>{
      'sub': 'ignore',
      'platform': 'web',
      'is_pro': isPro,
      'is_premium': isPremium,
      'exp': nowSec + _jwtTtlSeconds,
    };

    final h = _b64url(utf8.encode(json.encode(header)));
    final p = _b64url(utf8.encode(json.encode(payload)));
    final data = utf8.encode('$h.$p');
    final key = base64.decode(_jwtSecretB64);
    final sig = Hmac(sha256, key).convert(data).bytes;
    final token = '$h.$p.${_b64url(sig)}';
    Debug.log('SnapEdit JWT signed platform=web exp=${payload['exp']} len=${token.length}');
    return token;
  }

  /// Luôn có JWT hợp lệ (ký lại nếu sắp hết hạn).
  Future<bool> ensureAuthToken({bool force = false}) async {
    if (!force && isJwtValid) return true;
    if (_refreshing != null) {
      await _refreshing;
      return isJwtValid || _jwt.isNotEmpty;
    }
    _refreshing = Future(() async {
      _jwt = _signJwt();
      _jwtExpiresAt = DateTime.now().add(const Duration(seconds: _jwtTtlSeconds));
    });
    try {
      await _refreshing;
      return true;
    } finally {
      _refreshing = null;
    }
  }
}

extension HeaderBuilders on SnapEditConfig {
  /// Headers API — giữ style app mobile, JWT ký giống web.
  Map<String, String> get headers => {
        "User-Agent": "SnapEdit/$version (com.sfun.snapedit; build:155; iOS 15.6.1) Alamofire/5.6.2",
        "Authorization": "Bearer $jwt",
      };

  /// Assets public — không Bearer.
  Map<String, String> get publicHeaders => {
        "User-Agent": "SnapEdit/$version (com.sfun.snapedit; build:155; iOS 15.6.1) Alamofire/5.6.2",
        "Accept": "application/json",
      };
}
