import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:snapedit/common/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppConfig {
  final String appName;
  final String appLogo;
  final List<String> protocols;
  final String sharedKeyPrefix;
  final String contact;
  final String telegram;
  final ShareApp shareApp;
  final MaintenanceMode maintenanceMode;
  final AppMode appMode;

  AppConfig({
    required this.appName,
    required this.appLogo,
    required this.protocols,
    required this.sharedKeyPrefix,
    required this.contact,
    required this.shareApp,
    required this.maintenanceMode,
    required this.appMode,
    required this.telegram,
  });

  factory AppConfig.defaultValue() {
    return AppConfig(
      appName: "SnapEdit",
      appLogo: AppAssets.instance.logo,
      protocols: ['https://', 'http://', 'data:'],
      sharedKeyPrefix: "snapedit.",
      contact: "brennanngo992k@gmail.com",
      shareApp: ShareApp(
        link: '',
        message: "SnapEdit",
      ),
      telegram: '',
      maintenanceMode: const MaintenanceMode(
        title: "We'll be back soon",
        link: '',
        message: "We're very sorry for the inconvenience but we're performing maintaince. Please check back soon ...",
      ),
      appMode: AppMode.production,
    );
  }

  AppConfig copyWith({
    String? appName,
    String? appLogo,
    List<String>? protocols,
    String? sharedKeyPrefix,
    String? contact,
    ShareApp? shareApp,
    MaintenanceMode? maintenanceMode,
    AppMode? appMode,
    String? telegram,
  }) {
    return AppConfig(
      appName: appName ?? this.appName,
      appLogo: appLogo ?? this.appLogo,
      protocols: protocols ?? this.protocols,
      sharedKeyPrefix: sharedKeyPrefix ?? this.sharedKeyPrefix,
      contact: contact ?? this.contact,
      shareApp: shareApp ?? this.shareApp,
      appMode: appMode ?? this.appMode,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      telegram: telegram ?? this.telegram,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appName': appName,
      'appLogo': appLogo,
      'protocols': protocols,
      'sharedKeyPrefix': sharedKeyPrefix,
      'contact': contact,
      'shareApp': shareApp.toMap(),
      'appMode': appMode.name,
      'maintenanceMode': maintenanceMode.toMap(),
      'telegram': telegram,
    };
  }

  factory AppConfig.fromMap(Map<String, dynamic> map) {
    return AppConfig(
      appName: map['appName'] as String,
      appLogo: map['appLogo'] as String,
      protocols: (map['protocols'] as List).map((e) => e.toString()).toList(),
      sharedKeyPrefix: map['sharedKeyPrefix'] as String,
      contact: map['contact'] as String,
      shareApp: ShareApp.fromMap(map['shareApp']),
      appMode: AppMode.values.firstWhere((element) => element.name == map['appMode']),
      telegram: map['telegram'],
      maintenanceMode: MaintenanceMode.fromMap(map['maintenanceMode']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppConfig.fromJson(String source) => AppConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppConfig(appName: $appName, appLogo: $appLogo, protocols: $protocols, sharedKeyPrefix: $sharedKeyPrefix, shareApp: $shareApp, appMode: $appMode, maintenanceMode: $maintenanceMode, telegram: $telegram)';
  }

  @override
  bool operator ==(covariant AppConfig other) {
    if (identical(this, other)) return true;

    return other.appName == appName &&
        other.appLogo == appLogo &&
        listEquals(other.protocols, protocols) &&
        other.sharedKeyPrefix == sharedKeyPrefix &&
        other.contact == contact &&
        other.appMode == appMode &&
        other.maintenanceMode == maintenanceMode &&
        other.telegram == telegram &&
        other.shareApp == shareApp;
  }

  @override
  int get hashCode {
    return appName.hashCode ^
        appLogo.hashCode ^
        protocols.hashCode ^
        sharedKeyPrefix.hashCode ^
        contact.hashCode ^
        shareApp.hashCode ^
        maintenanceMode.hashCode ^
        telegram.hashCode ^
        appMode.hashCode;
  }
}

class ShareApp {
  final String message;
  final String link;

  ShareApp({
    required this.message,
    required this.link,
  });

  ShareApp copyWith({
    String? message,
    String? link,
  }) {
    return ShareApp(
      message: message ?? this.message,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'link': link,
    };
  }

  factory ShareApp.fromMap(Map<String, dynamic> map) {
    return ShareApp(
      message: map['message'] as String,
      link: map['link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShareApp.fromJson(String source) => ShareApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ShareApp(message: $message, link: $link)';

  @override
  bool operator ==(covariant ShareApp other) {
    if (identical(this, other)) return true;

    return other.message == message && other.link == link;
  }

  @override
  int get hashCode => message.hashCode ^ link.hashCode;
}

enum AppMode {
  production,
  debug,
  maintenance,
}

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
