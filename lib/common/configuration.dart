import 'dart:async';
import 'dart:convert';

import 'package:snapedit/models/config/app_config.dart';
import 'package:snapedit/common/constants.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snapedit/services/services.dart';

class Configuration {
  static final Configuration _instance = Configuration._internal();
  static Configuration get instance => _instance;

  factory Configuration() => _instance;

  Configuration._internal();

  /// FIREBASE CONFIGURATIONS
  FirebaseConfig _firebaseConfig = DefaultConfig.firebaseConfig;
  FirebaseConfig get firebaseConfig => _firebaseConfig;

  /// APP CONFIGUARATIONS
  AppConfig _appConfig = DefaultConfig.appConfig;
  AppConfig get appConfig => _appConfig;

  /// ADS CONFIGURATIONS
  AdvertisementConfig _advertisementConfig = DefaultConfig.advertisementConfig;
  AdvertisementConfig get advertisementConfig => _advertisementConfig;

  /// API CONFIGURATIONS
  SnapEditConfig _snapEditConfig = DefaultConfig.snapEditConfig;
  SnapEditConfig get snapEditConfig => _snapEditConfig;

  bool fromEnviroment(Map<String, dynamic> enviroment) {
    if (enviroment['appConfig'] != null) {
      _appConfig = AppConfig.fromMap(enviroment['appConfig']);
    }

    if (enviroment['firebaseConfig'] != null) {
      _firebaseConfig = FirebaseConfig.fromMap(enviroment['firebaseConfig']);
    }

    if (enviroment['advertisementConfig'] != null) {
      _advertisementConfig = AdvertisementConfig.fromMap(enviroment['advertisementConfig']);
    }

    if (enviroment['snapEditConfig'] != null) {
      _snapEditConfig = SnapEditConfig.fromMap(enviroment['snapEditConfig']);
    }

    return true;
  }
}

abstract class DefaultConfig {
  /// DEFAULT FIREBASE CONFIGURATIONS
  static FirebaseConfig firebaseConfig = FirebaseConfig(
    enableFirebase: false,
    enableCrashAnalytics: true,
    enableRemoteConfigFirebase: false,
    fetchTimeout: const Duration(seconds: 60), // 1 minutes
    minimumFetchInterval: const Duration(days: 1), // 1 day
  );

  /// DEFAULT API CONFIGURATIONS
  static SnapEditConfig snapEditConfig = SnapEditConfig.defaultValue();

  /// DEFAULT APP CONFIGURATIONS
  static AppConfig appConfig = AppConfig.defaultValue();

  /// DEFAULT ADS CONFIGURATIONS
  static AdvertisementConfig advertisementConfig = const AdvertisementConfig(
    enable: false,
    ads: [],
  );
}

extension ConfigurationsFireBaseRemoteConfig on Configuration {
  Future<void> loadRemoteConfig({Function? before}) async {
    /// load remote config from local
    await loadRemoteConfigFromLocalStore();

    bool isExpried = isExpriedRemoteConfig();

    /// if expried, get new remote config
    Debug.log('======= REMOTE CONFIG ON LOCAL IS EXPRITED $isExpried');

    if (isExpried && InternetConnection.instance.hasConnection) {
      Debug.log('====== SET REMOTE CONFIG FROM FIREBASE======');
      if (before != null) await before();

      FirebaseRemoteConfig? remoteConfig = Services().firebase.remoteConfig;

      if (remoteConfig == null) {
        return;
      }

      PackageInfo packageInfo = await PackageInfoExtesnion.getPackageInfo();
      String stringConfig = remoteConfig.getString(packageInfo.packageName.split('.').join().split('-').join().toLowerCase());

      if (stringConfig.isEmpty) {
        return;
      }

      /// setConfig in store
      AsyncStorage.instance.setString(AppSharedKey.instance.remoteConfig, stringConfig);

      Map<String, dynamic> enviroment = json.decode(stringConfig);

      fromEnviroment(enviroment);

      /// miliseconds
      AsyncStorage.instance.setInt(
        AppSharedKey.instance.remoteConfigExpriedDate,
        (Configuration.instance.firebaseConfig.minimumFetchInterval.inMilliseconds + DateTime.now().millisecondsSinceEpoch),
      );
    }
  }

  Future<bool> loadRemoteConfigFromLocalStore() async {
    /// enable remote config
    if (!firebaseConfig.enableRemoteConfigFirebase) {
      return false;
    }

    String? stringConfig = AsyncStorage.instance.getString(AppSharedKey.instance.remoteConfig);
    if (stringConfig == null) {
      return false;
    }

    Debug.log('====== SET REMOTE CONFIG FROM LOCAL ======');
    Map<String, dynamic> enviroment = json.decode(stringConfig);
    fromEnviroment(enviroment);
    return true;
  }

  bool isExpriedRemoteConfig() {
    int? timestampExpriedDate = AsyncStorage.instance.getInt(AppSharedKey.instance.remoteConfigExpriedDate);
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
    for (var protocol in appConfig.protocols) {
      if (url.startsWith(protocol)) {
        return true;
      }
    }
    return false;
  }
}
