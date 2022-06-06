part of '../configuration.dart';

class AppConfig {
  final String appName;
  final String appVersion;
  final String appColor;
  final String appLogo;
  final String appTheme;

  AppConfig({
    required this.appName,
    required this.appVersion,
    required this.appColor,
    required this.appLogo,
    required this.appTheme,
  });

  AppConfig copyWith({
    String? appName,
    String? appVersion,
    String? appColor,
    String? appLogo,
    String? appTheme,
  }) {
    return AppConfig(
      appName: appName ?? this.appName,
      appVersion: appVersion ?? this.appVersion,
      appColor: appColor ?? this.appColor,
      appLogo: appLogo ?? this.appLogo,
      appTheme: appTheme ?? this.appTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appName': appName,
      'appVersion': appVersion,
      'appColor': appColor,
      'appLogo': appLogo,
      'appTheme': appTheme,
    };
  }

  factory AppConfig.fromMap(Map<String, dynamic> map) {
    return AppConfig(
      appName: map['appName'] ?? '',
      appVersion: map['appVersion'] ?? '',
      appColor: map['appColor'] ?? '',
      appLogo: map['appLogo'] ?? '',
      appTheme: map['appTheme'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppConfig.fromJson(String source) => AppConfig.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppConfig(appName: $appName, appVersion: $appVersion, appColor: $appColor, appLogo: $appLogo, appTheme: $appTheme)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppConfig &&
        other.appName == appName &&
        other.appVersion == appVersion &&
        other.appColor == appColor &&
        other.appLogo == appLogo &&
        other.appTheme == appTheme;
  }

  @override
  int get hashCode {
    return appName.hashCode ^
        appVersion.hashCode ^
        appColor.hashCode ^
        appLogo.hashCode ^
        appTheme.hashCode;
  }
}
