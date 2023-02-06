import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:fluttering_iap/fluttering_iap.dart';
import 'package:snapeditify/models/config/bussiness_config.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snapeditify/models/config/gallery_config.dart';
import 'package:snapeditify/services/services.dart';
import 'package:fluttering_remote_config/fluttering_remote_config.dart';

class Configuration {
  static final Configuration _instance = Configuration._internal();
  static Configuration get instance => _instance;

  factory Configuration() => _instance;

  Configuration._internal();

  /// REMOTE CONFIGURATIONS
  AwesomeRemoteConfigSetting _remoteConfig = DefaultConfig.remoteConfig;
  AwesomeRemoteConfigSetting get remoteConfig => _remoteConfig;

  /// APP CONFIGUARATIONS
  BusinessConfig _business = DefaultConfig.business;
  BusinessConfig get business => _business;

  /// GALLERY CONFIGUARATIONS
  GalleryConfig _gallery = DefaultConfig.gallery;
  GalleryConfig get gallery => _gallery;

  // /// IAP CONFIGURATIONS
  // IAPConfig _iap = DefaultConfig.iap;
  // IAPConfig get iap => _iap;

  /// ADS CONFIGURATIONS
  AdvertisementConfig _advertisement = DefaultConfig.advertisement;
  AdvertisementConfig get advertisement => _advertisement;

  /// API CONFIGURATIONS
  SnapEditConfig _snapEdit = DefaultConfig.snapEdit;
  SnapEditConfig get snapEdit => _snapEdit;

  Future<void> loadLocalConfig(Map<String, dynamic> defaultConfig) async {
    fromEnviroment(defaultConfig);

    /// load remote config from local
    await loadRemoteConfigFromLocalStore();
  }

  void fromEnviroment(Map<String, dynamic> enviroment) {
    if (enviroment['business'] != null) {
      _business = BusinessConfig.fromMap(enviroment['business']);
    }

    if (enviroment['remoteConfig'] != null) {
      _remoteConfig = AwesomeRemoteConfigSetting.fromMap(enviroment['remoteConfig']);
    }

    if (enviroment['advertisement'] != null) {
      _advertisement = AdvertisementConfig.fromMap(enviroment['advertisement']);
    }

    if (enviroment['gallery'] != null) {
      _gallery = GalleryConfig.fromMap(enviroment['gallery']);
    }

    if (enviroment['snapEdit'] != null) {
      _snapEdit = SnapEditConfig.fromMap(enviroment['snapEdit']);
    }

    // if (enviroment['iap'] != null) {
    //   _iap = IAPConfig.fromMap(enviroment['iap']);
    // }
  }
}

abstract class DefaultConfig {
  /// DEFAULT CONFIGURATIONS
  static AwesomeRemoteConfigSetting remoteConfig = AwesomeRemoteConfigSetting(
    enable: false,
    provider: RemoteConfigProvider.google,
    fetchTimeout: const Duration(milliseconds: 60 * 1000), // 1 minutes
    minimumFetchInterval: const Duration(milliseconds: 24 * 60 * 1000), // 1 day
  );

  /// DEFAULT IN APP REVIEW CONFIGUARATIONS
  static InAppReviewConfig inAppReview = const InAppReviewConfig(
    enable: true,
    minDaysAfterInstall: 1,
    minDaysBeforeRemind: 1,
    minLaunchTimes: 1,
  );

  /// DEFAULT API CONFIGURATIONS
  static SnapEditConfig snapEdit = SnapEditConfig.defaultValue();

  /// DEFAULT APP CONFIGURATIONS
  static BusinessConfig business = BusinessConfig.defaultValue();

  /// DEFAULT ADS CONFIGURATIONS
  static AdvertisementConfig advertisement = const AdvertisementConfig(
    ads: [],
    enable: true,
  );

  /// GALLERY CONFIGUARATIONS
  static GalleryConfig gallery = GalleryConfig.defaultValue();

  // /// DEFAULT IAP CONFIG
  // static IAPConfig iap = const IAPConfig(
  //   products: [],
  //   enable: false,
  //   provider: IAPProvider.google,
  // );
}

extension ConfigurationsRemoteConfig on Configuration {
  Future<void> loadRemoteConfig({Function? before}) async {
    /// if not enabled return
    if(!_remoteConfig.enable) return;

    bool isExpried = isExpriedRemoteConfig();

    /// if expried, get new remote config
    Debug.log('======= REMOTE CONFIG ON LOCAL IS EXPRITED $isExpried =======');

    if (isExpried && InternetConnection.instance.hasConnection) {
      try {
        Debug.log('====== SET REMOTE CONFIG ======');
        if (before != null) await before();
  
        PackageInfo packageInfo = await PackageInfoExtesnion.getPackageInfo();
  
        /// app.snapeditify.studio
        /// => app_snapeditify_studio
        String remoteKey = packageInfo.packageName.split('.').join('_').split('-').join().toLowerCase();
        Debug.log(remoteKey);
  
        String? stringConfig = await AwesomeRemoteConfig.instance.getConfig(remoteKey);
        if(stringConfig == null || stringConfig.isEmpty) throw ErrorDescription('REMOTE CONFIG EMPTY');
  
        Debug.log('====== REMOTE CONFIG======');
        Debug.log(stringConfig);

      
        Debug.log('====== SET REMOTE CONFIG ======');
        Map<String, dynamic> enviroment = json.decode(stringConfig);
        fromEnviroment(enviroment);

        /// setConfig in store
        AsyncStorage.instance.setString(AsyncStorageKey.instance.remoteConfig, stringConfig);

         /// miliseconds
        AsyncStorage.instance.setInt(
          AsyncStorageKey.instance.remoteConfigExpriedDate,
          (Configuration.instance.remoteConfig.minimumFetchInterval.inMilliseconds + DateTime.now().millisecondsSinceEpoch),
        );
      }catch(error) {
         Debug.log('====== SET REMOTE CONFIG ERROR $error======');
      }
    }
  }

  Future<bool> loadRemoteConfigFromLocalStore() async {
    String? stringConfig = AsyncStorage.instance.getString(AsyncStorageKey.instance.remoteConfig);
    if (stringConfig == null) {
      return false;
    }

    try {
      Debug.log('====== SET REMOTE CONFIG FROM LOCAL ======');
      Map<String, dynamic> enviroment = json.decode(stringConfig);
      fromEnviroment(enviroment);
      return true;
    }catch(error) {
      Debug.log('====== SET REMOTE CONFIG FROM LOCAL ERROR $error======');
      return false;

    }
  }

  bool isExpriedRemoteConfig() {
    int? timestampExpriedDate = AsyncStorage.instance.getInt(AsyncStorageKey.instance.remoteConfigExpriedDate);
    int timestampNow = DateTime.now().millisecondsSinceEpoch;
    if (timestampExpriedDate == null || (timestampNow > timestampExpriedDate)) return true;
    return false;
  }
}

extension PackageInfoExtesnion on Configuration {
  static Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String packageName = packageInfo.packageName;

    Debug.log('APP ID: $packageName');
    Debug.log('APP NAME $appName');
    Debug.log('APP VERSION $version');
    Debug.log('App VERSION CODE $buildNumber');

    return packageInfo;
  }
}

extension NetworkExtension on Configuration {
  bool isNetwork(String url) {
    for (var protocol in business.protocols) {
      if (url.startsWith(protocol)) {
        return true;
      }
    }
    return false;
  }
}
