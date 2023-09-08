import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'update_app.dart';
import 'app_platform.dart';
import 'maintenance_mode.dart';
import 'more_app.dart';
import 'share_app.dart';
import 'social_network.dart';
import 'web_link.dart';

enum AppMode {
  production,
  debug,
  maintenance,
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BusinessConfig {
  final String appName;
  final String appLogo;
  final String appBio;
  final List<String> protocols;
  final String prefix;
  final String contact;
  final List<SocialNetwork> socialNetworks;
  final List<WebLink> webLinks;
  final List<MoreApp> moreApps;
  final ShareApp shareApp;
  final UpdateApp updateApp;
  final MaintenanceMode maintenanceMode;
  final AppMode appMode;
  final String version;

  BusinessConfig({
    required this.appName,
    required this.appLogo,
    required this.appBio,
    required this.protocols,
    required this.prefix,
    required this.contact,
    required this.socialNetworks,
    required this.webLinks,
    required this.moreApps,
    required this.shareApp,
    required this.updateApp,
    required this.maintenanceMode,
    required this.appMode,
    required this.version,
  });

  factory BusinessConfig.defaultValue() {
    return BusinessConfig(
      appName: "SnapEditify",
      appLogo: "assets/images/logo.png",
      appBio: "AI powered photo editor",
      protocols: ['https://', 'http://', 'data:'],
      prefix: "app.snapeditify.studio.",
      contact: "contact.snapeditify@gmail.com",
      shareApp: ShareApp(
        links: {
          AppPlatform.android: 'https://appgallery.huawei.com/app/C107645049',
          AppPlatform.ios: 'https://appgallery.huawei.com/app/C107645049',
          AppPlatform.huawei: 'https://appgallery.huawei.com/app/C107645049',
        },
        message: "SnapEditify AI Photo Editor",
      ),
      updateApp: UpdateApp(
        version: '2.0.0',
        required: false,
        links: {
          AppPlatform.android: 'https://appgallery.huawei.com/app/C107645049',
          AppPlatform.ios: 'https://appgallery.huawei.com/app/C107645049',
          AppPlatform.huawei: 'https://appgallery.huawei.com/app/C107645049',
        },
      ),
      socialNetworks: [
        SocialNetwork.fromMap({
          'brand': 'Facebook',
          'link': 'https://www.facebook.com/snapeditify/',
          'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/600px-Facebook_Logo_%282019%29.png',
        }),
        SocialNetwork.fromMap({
          'brand': 'Tiktok',
          'link': 'https://www.tiktok.com/@snapeditify',
          'image': 'https://cdn4.iconfinder.com/data/icons/social-media-flat-7/64/Social-media_Tiktok-512.png',
        }),
        SocialNetwork.fromMap({
          'brand': 'Youtube',
          'link': 'https://www.youtube.com/@snapeditify',
          'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/318px-YouTube_full-color_icon_%282017%29.svg.png',
        }),
        SocialNetwork.fromMap({
          'brand': 'Telegram',
          'link': 'https://t.me/+GPyDosamyKA2OGVl',
          'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/512px-Telegram_logo.svg.png?20220101141644',
        }),
      ],
      webLinks: [
        WebLink.fromMap({
          'title': 'Terms of service',
          'link': 'https://snapeditify.netlify.app/terms-of-service/',
          'image': 'assets/images/icons/ic_term.png',
        }),
        WebLink.fromMap({
          'title': 'Privacy policy',
          'link': 'https://snapeditify.netlify.app/privacy-policy/',
          'image': 'assets/images/icons/ic_term.png',
        }),
        WebLink.fromMap({
          'title': 'FAQ',
          'link': 'https://snapeditify.netlify.app/faq/',
          'image': 'assets/images/icons/ic_faq.png',
        })
      ],
      maintenanceMode: MaintenanceMode.fromMap({
        'title': "We'll be back soon",
        'link': 'https://snapeditify.netlify.app/',
        'message': "We're very sorry for the inconvenience but we're performing maintaince. Please check back soon ...",
      }),
      moreApps: [],
      version: '2.0.0',
      appMode: kDebugMode? AppMode.debug: AppMode.production,
    );
  }

  BusinessConfig copyWith({
    String? appName,
    String? appLogo,
    String? appBio,
    List<String>? protocols,
    String? prefix,
    String? contact,
    List<SocialNetwork>? socialNetworks,
    List<WebLink>? webLinks,
    List<MoreApp>? moreApps,
    ShareApp? shareApp,
    UpdateApp? updateApp,
    MaintenanceMode? maintenanceMode,
    AppMode? appMode,
    String? version,
  }) {
    return BusinessConfig(
      appName: appName ?? this.appName,
      appLogo: appLogo ?? this.appLogo,
      appBio: appBio ?? this.appBio,
      protocols: protocols ?? this.protocols,
      prefix: prefix ?? this.prefix,
      contact: contact ?? this.contact,
      shareApp: shareApp ?? this.shareApp,
      updateApp: updateApp ?? this.updateApp,
      appMode: appMode ?? this.appMode,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      socialNetworks: socialNetworks ?? this.socialNetworks,
      webLinks: webLinks ?? this.webLinks,
      moreApps: moreApps ?? this.moreApps,
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appName': appName,
      'appLogo': appLogo,
      'appBio': appBio,
      'protocols': protocols,
      'prefix': prefix,
      'contact': contact,
      'shareApp': shareApp.toMap(),
      'updateApp': updateApp.toMap(),
      'appMode': appMode.name,
      'maintenanceMode': maintenanceMode.toMap(),
      'socialNetworks': socialNetworks.map((e) => e.toMap()),
      'webLinks': webLinks.map((e) => e.toMap()),
      'version': version,
      'moreApps': moreApps.map((e) => e.toMap()),
    };
  }

  factory BusinessConfig.fromMap(Map<String, dynamic> map) {
    return BusinessConfig.defaultValue().copyWith(
      appName: map['appName'],
      appLogo: map['appLogo'],
      appBio: map['appBio'],
      protocols: map['protocols'] != null? (map['protocols'] as List).map((e) => e.toString()).toList(): null,
      prefix: map['prefix'],
      contact: map['contact'],
      shareApp: map['shareApp'] != null? ShareApp.fromMap(map['shareApp']): null,
      updateApp: map['updateApp'] != null ? UpdateApp.fromMap(map['updateApp']): null,
      moreApps: map['moreApps'] != null? (map['moreApps'] as List).map<MoreApp>((e) => MoreApp.fromMap(e)).toList(): null,
      appMode: map['appMode'] != null? AppMode.values.firstWhere((element) => element.name == map['appMode']): null,
      socialNetworks: map['socialNetworks'] != null? (map['socialNetworks'] as List).map<SocialNetwork>((e) => SocialNetwork.fromMap(e)).toList(): null,
      webLinks: map['webLinks'] != null? (map['webLinks'] as List).map<WebLink>((e) => WebLink.fromMap(e)).toList(): null,
      maintenanceMode: map['maintenanceMode'] != null? MaintenanceMode.fromMap(map['maintenanceMode']): null,
      version: map['version'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessConfig.fromJson(String source) => BusinessConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BusinessConfig(appName: $appName, appLogo: $appLogo, appBio: $appBio, protocols: $protocols, prefix: $prefix, contact: $contact, socialNetworks: $socialNetworks, moreApps: $moreApps, webLinks: $webLinks, shareApp: $shareApp, updateApp: $updateApp, maintenanceMode: $maintenanceMode, appMode: $appMode, version: $version)';
  }

  @override
  bool operator ==(covariant BusinessConfig other) {
    if (identical(this, other)) return true;

    return other.appName == appName &&
        other.appLogo == appLogo &&
        other.appBio == appBio &&
        listEquals(other.protocols, protocols) &&
        other.prefix == prefix &&
        other.contact == contact &&
        listEquals(other.socialNetworks, socialNetworks) &&
        listEquals(other.webLinks, webLinks) &&
        other.shareApp == shareApp &&
        other.updateApp == updateApp &&
        other.moreApps == moreApps &&
        other.maintenanceMode == maintenanceMode &&
        other.appMode == appMode &&
        other.version == version;
  }

  @override
  int get hashCode {
    return appName.hashCode ^
        appLogo.hashCode ^
        appBio.hashCode ^
        protocols.hashCode ^
        prefix.hashCode ^
        contact.hashCode ^
        socialNetworks.hashCode ^
        webLinks.hashCode ^
        shareApp.hashCode ^
        updateApp.hashCode ^
        moreApps.hashCode ^
        maintenanceMode.hashCode ^
        appMode.hashCode ^
        version.hashCode;
  }
}
