import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:snapeditify/models/config/maintenance_mode.dart';
import 'package:snapeditify/models/config/share_app.dart';
import 'package:snapeditify/models/config/social_network.dart';
import 'package:snapeditify/models/config/web_link.dart';

enum AppMode {
  production,
  debug,
  maintenance,
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BusinessConfig {
  final String appName;
  final String appLogo;
  final List<String> protocols;
  final String prefix;
  final String contact;
  final List<SocialNetwork> socialNetworks;
  final List<WebLink> webLinks;
  final ShareApp shareApp;
  final MaintenanceMode maintenanceMode;
  final AppMode appMode;
  final String version;

  BusinessConfig({
    required this.appName,
    required this.appLogo,
    required this.protocols,
    required this.prefix,
    required this.contact,
    required this.shareApp,
    required this.maintenanceMode,
    required this.appMode,
    required this.socialNetworks,
    required this.webLinks,
    required this.version,
  });

  factory BusinessConfig.defaultValue() {
    return BusinessConfig(
      appName: "SnapEditify AI Photo Editor Pro",
      appLogo: "",
      protocols: ['https://', 'http://', 'data:'],
      prefix: "app.snapeditify.studio",
      contact: "brennanngo992k@gmail.com",
      shareApp: ShareApp(
        links: {
          ShareAppPlatform.android: '',
          ShareAppPlatform.ios: '',
          ShareAppPlatform.huawei: '',
        },
        message: "SnapEditify AI Photo Editor Pro",
      ),
      socialNetworks: [],
      webLinks: [],
      maintenanceMode: const MaintenanceMode(
        title: "We'll be back soon",
        link: '',
        message: "We're very sorry for the inconvenience but we're performing maintaince. Please check back soon ...",
      ),
      version: '1.0.0',
      appMode: AppMode.debug,
    );
  }

  BusinessConfig copyWith({
    String? appName,
    String? appLogo,
    List<String>? protocols,
    String? prefix,
    String? contact,
    ShareApp? shareApp,
    MaintenanceMode? maintenanceMode,
    AppMode? appMode,
    List<SocialNetwork>? socialNetworks,
    List<WebLink>? webLinks,
    String? version,
  }) {
    return BusinessConfig(
      appName: appName ?? this.appName,
      appLogo: appLogo ?? this.appLogo,
      protocols: protocols ?? this.protocols,
      prefix: prefix ?? this.prefix,
      contact: contact ?? this.contact,
      shareApp: shareApp ?? this.shareApp,
      appMode: appMode ?? this.appMode,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      socialNetworks: socialNetworks ?? this.socialNetworks,
      webLinks: webLinks ?? this.webLinks,
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appName': appName,
      'appLogo': appLogo,
      'protocols': protocols,
      'prefix': prefix,
      'contact': contact,
      'shareApp': shareApp.toMap(),
      'appMode': appMode.name,
      'maintenanceMode': maintenanceMode.toMap(),
      'socialNetworks': socialNetworks.map((e) => e.toMap()),
      'webLinks': webLinks.map((e) => e.toMap()),
      'version': version,
    };
  }

  factory BusinessConfig.fromMap(Map<String, dynamic> map) {
    return BusinessConfig(
      appName: map['appName'] as String,
      appLogo: map['appLogo'] as String,
      protocols: (map['protocols'] as List).map((e) => e.toString()).toList(),
      prefix: map['prefix'] as String,
      contact: map['contact'] as String,
      shareApp: ShareApp.fromMap(map['shareApp']),
      appMode: AppMode.values.firstWhere((element) => element.name == map['appMode']),
      socialNetworks: map['socialNetworks'].map<SocialNetwork>((e) => SocialNetwork.fromMap(e)).toList(),
      webLinks: map['webLinks'].map<WebLink>((e) => WebLink.fromMap(e)).toList(),
      maintenanceMode: MaintenanceMode.fromMap(map['maintenanceMode']),
      version: map['version'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessConfig.fromJson(String source) => BusinessConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BusinessConfig(appName: $appName, appLogo: $appLogo, protocols: $protocols, prefix: $prefix, shareApp: $shareApp, appMode: $appMode, maintenanceMode: $maintenanceMode, socialNetworks: $socialNetworks, webLinks: $webLinks, version: $version)';
  }

  @override
  bool operator ==(covariant BusinessConfig other) {
    if (identical(this, other)) return true;

    return other.appName == appName &&
        other.appLogo == appLogo &&
        listEquals(other.protocols, protocols) &&
        other.prefix == prefix &&
        other.contact == contact &&
        other.appMode == appMode &&
        other.maintenanceMode == maintenanceMode &&
        other.socialNetworks == socialNetworks &&
        other.webLinks == webLinks &&
        other.shareApp == shareApp &&
        other.version == version;
  }

  @override
  int get hashCode {
    return appName.hashCode ^
        appLogo.hashCode ^
        protocols.hashCode ^
        prefix.hashCode ^
        contact.hashCode ^
        shareApp.hashCode ^
        maintenanceMode.hashCode ^
        socialNetworks.hashCode ^
        webLinks.hashCode ^
        appMode.hashCode ^
        version.hashCode;
  }
}
