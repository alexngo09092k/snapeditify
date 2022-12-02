import 'dart:async';
import 'dart:convert';

import 'package:snapedit/models/config/app_config.dart';
import 'package:snapedit/common/constants.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapedit/services/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snapedit/common/extensions.dart';
import 'package:snapedit/services/snap_edit/models/snapedit_api_config.dart';

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
  static SnapEditConfig snapEditConfig = SnapEditConfig(
    baseUrl: 'https://be-prod-1.snapedit.app',
  );

  /// DEFAULT APP CONFIGURATIONS
  static AppConfig appConfig = AppConfig(
    appName: "SnapEdit",
    appLogo: AppAssets.instance.logo,
    protocols: ['https://', 'http://', 'data:'],
    sharedKeyPrefix: "snapedit.",
    contact: "brennanngo992k@gmail.com",
    shareApp: ShareApp(link: 'https://t.me/+9UBuQxKY7N80YTc1', message: "BlockScan"),
    telegram: 'https://t.me/+9UBuQxKY7N80YTc1',
    maintenanceMode: const MaintenanceMode(
      title: "We'll be back soon",
      link: 'https://t.me/+9UBuQxKY7N80YTc1',
      message: "We're very sorry for the inconvenience but we're performing maintaince. Please check back soon ...",
    ),
    appMode: AppMode.production,
  );

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

    if (isExpried && await ClientHttp.instance.shouldSendRequest()) {
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
