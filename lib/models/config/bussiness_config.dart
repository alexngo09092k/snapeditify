import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BusinessConfig {
  final String appName;
  final String appLogo;
  final List<String> protocols;
  final String sharedKeyPrefix;
  final String contact;
  final List<SocialNetwork> socialNetworks;
  final ShareApp shareApp;
  final MaintenanceMode maintenanceMode;
  final AppMode appMode;
  final String version;

  BusinessConfig({
    required this.appName,
    required this.appLogo,
    required this.protocols,
    required this.sharedKeyPrefix,
    required this.contact,
    required this.shareApp,
    required this.maintenanceMode,
    required this.appMode,
    required this.socialNetworks,
    required this.version,
  });

  factory BusinessConfig.defaultValue() {
    return BusinessConfig(
      appName: "Phosart AI Photo Editor Pro",
      appLogo: "",
      protocols: ['https://', 'http://', 'data:'],
      sharedKeyPrefix: "app.phosart.studio",
      contact: "brennanngo992k@gmail.com",
      shareApp: ShareApp(
        link: '',
        message: "Phosart AI Photo Editor Pro",
      ),
      socialNetworks: [],
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
    String? sharedKeyPrefix,
    String? contact,
    ShareApp? shareApp,
    MaintenanceMode? maintenanceMode,
    AppMode? appMode,
    List<SocialNetwork>? socialNetworks,
    String? version,
  }) {
    return BusinessConfig(
      appName: appName ?? this.appName,
      appLogo: appLogo ?? this.appLogo,
      protocols: protocols ?? this.protocols,
      sharedKeyPrefix: sharedKeyPrefix ?? this.sharedKeyPrefix,
      contact: contact ?? this.contact,
      shareApp: shareApp ?? this.shareApp,
      appMode: appMode ?? this.appMode,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      socialNetworks: socialNetworks ?? this.socialNetworks,
      version: version ?? this.version,
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
      'socialNetworks': socialNetworks.map((e) => e.toMap()),
      'version': version,
    };
  }

  factory BusinessConfig.fromMap(Map<String, dynamic> map) {
    return BusinessConfig(
      appName: map['appName'] as String,
      appLogo: map['appLogo'] as String,
      protocols: (map['protocols'] as List).map((e) => e.toString()).toList(),
      sharedKeyPrefix: map['sharedKeyPrefix'] as String,
      contact: map['contact'] as String,
      shareApp: ShareApp.fromMap(map['shareApp']),
      appMode: AppMode.values.firstWhere((element) => element.name == map['appMode']),
      socialNetworks: map['socialNetworks'].map<SocialNetwork>((e) => SocialNetwork.fromMap(e)).toList(),
      maintenanceMode: MaintenanceMode.fromMap(map['maintenanceMode']),
      version: map['version'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessConfig.fromJson(String source) => BusinessConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BusinessConfig(appName: $appName, appLogo: $appLogo, protocols: $protocols, sharedKeyPrefix: $sharedKeyPrefix, shareApp: $shareApp, appMode: $appMode, maintenanceMode: $maintenanceMode, socialNetworks: $socialNetworks, version: $version)';
  }

  @override
  bool operator ==(covariant BusinessConfig other) {
    if (identical(this, other)) return true;

    return other.appName == appName &&
        other.appLogo == appLogo &&
        listEquals(other.protocols, protocols) &&
        other.sharedKeyPrefix == sharedKeyPrefix &&
        other.contact == contact &&
        other.appMode == appMode &&
        other.maintenanceMode == maintenanceMode &&
        other.socialNetworks == socialNetworks &&
        other.shareApp == shareApp &&
        other.version == version;
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
        socialNetworks.hashCode ^
        appMode.hashCode ^
        version.hashCode;
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

class SocialNetwork {
  final String link;
  final String brand;
  final String image;

  SocialNetwork({
    required this.link,
    required this.brand,
    required this.image,
  });

  SocialNetwork copyWith({
    String? link,
    String? brand,
    String? image,
  }) {
    return SocialNetwork(
      link: link ?? this.link,
      brand: brand ?? this.brand,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link': link,
      'brand': brand,
      'image': image,
    };
  }

  factory SocialNetwork.fromMap(Map<String, dynamic> map) {
    return SocialNetwork(
      link: map['link'] as String,
      brand: map['brand'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialNetwork.fromJson(String source) => SocialNetwork.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SocialNetwork(link: $link, brand: $brand, image: $image)';

  @override
  bool operator ==(covariant SocialNetwork other) {
    if (identical(this, other)) return true;
  
    return 
      other.link == link &&
      other.brand == brand &&
      other.image == image;
  }

  @override
  int get hashCode => link.hashCode ^ brand.hashCode ^ image.hashCode;
}
