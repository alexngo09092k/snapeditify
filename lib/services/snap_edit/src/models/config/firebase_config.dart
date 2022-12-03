// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SnapeditFirebaseConfig {
  /// enable_app_check
  final bool enableAppCheck;

  /// enable_watermark
  final bool enableWaterMark;

  /// fetch_interval_in_hour
  final double fetchIntervalInHours;

  /// fetch_timeout_in_second
  final double fetchTimeoutInSeconds;

  /// hide_suggestion_images_after_saved
  final int hideSuggestionImagesAfterSaved;

  /// jwt_duration_in_min
  final int jwtDurationInMinutes;

  /// latest_app_version
  final String latestAppVersion;

  /// max_free_download_count
  final int maxFreeDownloadCount;

  /// min_force_update_app_version
  final String minForceUpdateAppVersion;

  /// min_suggested_app_version
  final String minSuggestedAppVersion;

  /// request_timeout_in_second
  final double requestTimeoutInSecond;

  SnapeditFirebaseConfig({
    required this.enableAppCheck,
    required this.enableWaterMark,
    required this.fetchIntervalInHours,
    required this.fetchTimeoutInSeconds,
    required this.hideSuggestionImagesAfterSaved,
    required this.jwtDurationInMinutes,
    required this.latestAppVersion,
    required this.maxFreeDownloadCount,
    required this.minForceUpdateAppVersion,
    required this.minSuggestedAppVersion,
    required this.requestTimeoutInSecond,
  });

  SnapeditFirebaseConfig copyWith({
    bool? enableAppCheck,
    bool? enableWaterMark,
    double? fetchIntervalInHours,
    double? fetchTimeoutInSeconds,
    int? hideSuggestionImagesAfterSaved,
    int? jwtDurationInMinutes,
    String? latestAppVersion,
    int? maxFreeDownloadCount,
    String? minForceUpdateAppVersion,
    String? minSuggestedAppVersion,
    double? requestTimeoutInSecond,
  }) {
    return SnapeditFirebaseConfig(
      enableAppCheck: enableAppCheck ?? this.enableAppCheck,
      enableWaterMark: enableWaterMark ?? this.enableWaterMark,
      fetchIntervalInHours: fetchIntervalInHours ?? this.fetchIntervalInHours,
      fetchTimeoutInSeconds: fetchTimeoutInSeconds ?? this.fetchTimeoutInSeconds,
      hideSuggestionImagesAfterSaved: hideSuggestionImagesAfterSaved ?? this.hideSuggestionImagesAfterSaved,
      jwtDurationInMinutes: jwtDurationInMinutes ?? this.jwtDurationInMinutes,
      latestAppVersion: latestAppVersion ?? this.latestAppVersion,
      maxFreeDownloadCount: maxFreeDownloadCount ?? this.maxFreeDownloadCount,
      minForceUpdateAppVersion: minForceUpdateAppVersion ?? this.minForceUpdateAppVersion,
      minSuggestedAppVersion: minSuggestedAppVersion ?? this.minSuggestedAppVersion,
      requestTimeoutInSecond: requestTimeoutInSecond ?? this.requestTimeoutInSecond,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enableAppCheck': enableAppCheck,
      'enableWaterMark': enableWaterMark,
      'fetchIntervalInHours': fetchIntervalInHours,
      'fetchTimeoutInSeconds': fetchTimeoutInSeconds,
      'hideSuggestionImagesAfterSaved': hideSuggestionImagesAfterSaved,
      'jwtDurationInMinutes': jwtDurationInMinutes,
      'latestAppVersion': latestAppVersion,
      'maxFreeDownloadCount': maxFreeDownloadCount,
      'minForceUpdateAppVersion': minForceUpdateAppVersion,
      'minSuggestedAppVersion': minSuggestedAppVersion,
      'requestTimeoutInSecond': requestTimeoutInSecond,
    };
  }

  factory SnapeditFirebaseConfig.fromMap(Map<String, dynamic> map) {
    return SnapeditFirebaseConfig(
      enableAppCheck: map['enableAppCheck'] as bool,
      enableWaterMark: map['enableWaterMark'] as bool,
      fetchIntervalInHours: map['fetchIntervalInHours'] as double,
      fetchTimeoutInSeconds: map['fetchTimeoutInSeconds'] as double,
      hideSuggestionImagesAfterSaved: map['hideSuggestionImagesAfterSaved'] as int,
      jwtDurationInMinutes: map['jwtDurationInMinutes'] as int,
      latestAppVersion: map['latestAppVersion'] as String,
      maxFreeDownloadCount: map['maxFreeDownloadCount'] as int,
      minForceUpdateAppVersion: map['minForceUpdateAppVersion'] as String,
      minSuggestedAppVersion: map['minSuggestedAppVersion'] as String,
      requestTimeoutInSecond: map['requestTimeoutInSecond'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SnapeditFirebaseConfig.fromJson(String source) => SnapeditFirebaseConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SnapeditFirebaseConfig(enableAppCheck: $enableAppCheck, enableWaterMark: $enableWaterMark, fetchIntervalInHours: $fetchIntervalInHours, fetchTimeoutInSeconds: $fetchTimeoutInSeconds, hideSuggestionImagesAfterSaved: $hideSuggestionImagesAfterSaved, jwtDurationInMinutes: $jwtDurationInMinutes, latestAppVersion: $latestAppVersion, maxFreeDownloadCount: $maxFreeDownloadCount, minForceUpdateAppVersion: $minForceUpdateAppVersion, minSuggestedAppVersion: $minSuggestedAppVersion, requestTimeoutInSecond: $requestTimeoutInSecond)';
  }

  @override
  bool operator ==(covariant SnapeditFirebaseConfig other) {
    if (identical(this, other)) return true;

    return other.enableAppCheck == enableAppCheck &&
        other.enableWaterMark == enableWaterMark &&
        other.fetchIntervalInHours == fetchIntervalInHours &&
        other.fetchTimeoutInSeconds == fetchTimeoutInSeconds &&
        other.hideSuggestionImagesAfterSaved == hideSuggestionImagesAfterSaved &&
        other.jwtDurationInMinutes == jwtDurationInMinutes &&
        other.latestAppVersion == latestAppVersion &&
        other.maxFreeDownloadCount == maxFreeDownloadCount &&
        other.minForceUpdateAppVersion == minForceUpdateAppVersion &&
        other.minSuggestedAppVersion == minSuggestedAppVersion &&
        other.requestTimeoutInSecond == requestTimeoutInSecond;
  }

  @override
  int get hashCode {
    return enableAppCheck.hashCode ^
        enableWaterMark.hashCode ^
        fetchIntervalInHours.hashCode ^
        fetchTimeoutInSeconds.hashCode ^
        hideSuggestionImagesAfterSaved.hashCode ^
        jwtDurationInMinutes.hashCode ^
        latestAppVersion.hashCode ^
        maxFreeDownloadCount.hashCode ^
        minForceUpdateAppVersion.hashCode ^
        minSuggestedAppVersion.hashCode ^
        requestTimeoutInSecond.hashCode;
  }
}
