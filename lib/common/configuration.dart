import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering_analytics/analytics/index.dart';
import 'package:fluttering_iap/fluttering_iap.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/models/config/bussiness_config/bussiness_config.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snapeditify/services/services.dart';
import 'package:fluttering_remote_config/fluttering_remote_config.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/base/custom_alert.dart';
import 'package:url_launcher/url_launcher.dart';

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

  /// IAP CONFIGURATIONS
  IAPConfig _iap = DefaultConfig.iap;
  IAPConfig get iap => _iap;

  /// ADS CONFIGURATIONS
  AdvertisementConfig _advertisement = DefaultConfig.advertisement;
  AdvertisementConfig get advertisement => _advertisement;

  /// ANALYTICS CONFIGURATIONS
  AnalyticsConfig _analytics = DefaultConfig.analytics;
  AnalyticsConfig get analytics => _analytics;

  /// API CONFIGURATIONS
  final SnapEditConfig _snapEdit = DefaultConfig.snapEdit;
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

    if (enviroment['iap'] != null) {
      _iap = IAPConfig.fromMap(enviroment['iap']);
    }

    if(enviroment['analytics'] != null) {
      _analytics = AnalyticsConfig.fromMap(enviroment['analytics']);
    }
  }
}

abstract class DefaultConfig {
  /// DEFAULT API CONFIGURATIONS
  static SnapEditConfig snapEdit = SnapEditConfig.defaultValue();

  /// DEFAULT CONFIGURATIONS
  static AwesomeRemoteConfigSetting remoteConfig = AwesomeRemoteConfigSetting(
    enable: kDebugMode,
    providers: [RemoteConfigProvider.google, RemoteConfigProvider.huawei],
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

  /// DEFAULT APP CONFIGURATIONS
  static BusinessConfig business = BusinessConfig.defaultValue();

  /// DEFAULT ADS CONFIGURATIONS
  static AdvertisementConfig advertisement = AdvertisementConfig(
    enable: kDebugMode,
    ads: [
      /// GOOGLE
      AdvertisementItem.fromMap({
        "type": "openApp",
        "provider": "google",
        "iosId": "ca-app-pub-3940256099942544/3419835294",
        "androidId": "ca-app-pub-3940256099942544/3419835294",
      }),
      AdvertisementItem.fromMap({
        "type": "banner",
        "provider": "google",
        "iosId": "ca-app-pub-3940256099942544/6300978111",
        "androidId": "ca-app-pub-3940256099942544/6300978111",
      }),
      AdvertisementItem.fromMap({
        "type": "interstitial",
        "provider": "google",
        "iosId": "ca-app-pub-3940256099942544/1033173712",
        "androidId": "ca-app-pub-3940256099942544/6300978111",
      }),
      AdvertisementItem.fromMap({
        "type": "reward",
        "provider": "google",
        "iosId": "ca-app-pub-3940256099942544/5224354917",
        "androidId": "ca-app-pub-3940256099942544/5224354917",
      }),
      AdvertisementItem.fromMap({
        "type": "native",
        "provider": "google",
        "iosId": "ca-app-pub-3940256099942544/6300978111",
        "androidId": "ca-app-pub-3940256099942544/6300978111",
      }),

      ///HUAWEI
      AdvertisementItem.fromMap({
        "type": "roll",
        "provider": "huawei",
        "iosId": "testy3cglm3pj0",
        "androidId": "testy3cglm3pj0",
      }),
      AdvertisementItem.fromMap({
        "type": "interstitial",
        "provider": "huawei",
        "iosId": "teste9ih9j0rc3",
        "androidId": "teste9ih9j0rc3",
      }),
      AdvertisementItem.fromMap( {
        "type": "reward",
        "provider": "huawei",
        "iosId": "testx9dtjwj8hp",
        "androidId": "testx9dtjwj8hp",
      }),
    ],
    providers: [AdvertisementProvider.google, AdvertisementProvider.huawei],
  );

  /// DEFAULT IAP CONFIG
  static IAPConfig iap = const IAPConfig(
    enable: kDebugMode,
    products: [],
    providers: [IAPProvider.google, IAPProvider.huawei],
  );

  static AnalyticsConfig analytics = const AnalyticsConfig(
    enable: kDebugMode,
    providers: [AnalyticsProvider.google, AnalyticsProvider.huawei],
  );
}

extension ConfigurationsRemoteConfig on Configuration {
  Future<void> loadRemoteConfig({Function? before}) async {
    /// if not enabled return
    if (!_remoteConfig.enable) return;

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
        Debug.log('====== REMOTE KEY======');
        Debug.log(remoteKey);

        String? stringConfig = await AwesomeRemoteConfig.instance.getConfig(remoteKey);
        if (stringConfig == null || stringConfig.isEmpty) {
          throw ErrorDescription('REMOTE CONFIG EMPTY');
        }

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
      } catch (error) {
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
    } catch (error) {
      Debug.log('====== SET REMOTE CONFIG FROM LOCAL ERROR $error======');
      return false;
    }
  }

  bool isExpriedRemoteConfig() {
    int? timestampExpriedDate = AsyncStorage.instance.getInt(AsyncStorageKey.instance.remoteConfigExpriedDate);
    int timestampNow = DateTime.now().millisecondsSinceEpoch;
    if (timestampExpriedDate == null || (timestampNow > timestampExpriedDate)) {
      return true;
    }
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

extension UpdateAppExtension on Configuration {

  Future<T?> checkAppUpdate<T>() async {
    final bool isUpdated = await _hasNewVersion();
    if(isUpdated && InternetConnection.instance.hasConnection && business.updateApp.link != null)  {
      return AwesomeAppState.useContext<T>(callback: (BuildContext context) {
        return WidgetUtils.instance.alert<T>(
          context,
          barrierDismissible: false,
          title: S.of(context).yourAppIsOutdated,
          message: S.of(context).yourAppVersionIsNoLongerSupportedYoureMissingOut,
          actions: [
            if(!business.updateApp.required) AlertAction(
              title: S.of(context).later, 
              onPressed: WidgetUtils.instance.dimiss,
              isDestructiveAction: true,
            ),
            AlertAction(
              title: S.of(context).update,
              onPressed: () async {
                try {
                  await launchUrl(Uri.parse( business.updateApp.link!));
                }catch(error) {
                  Debug.log('UPDATE APP ERRROR $error');
                }finally {
                  WidgetUtils.instance.dimiss();
                }
              },
            ),
          ],
        );
      });
    }
    return null;
  }

  Future<bool> _hasNewVersion() async {
    final PackageInfo packageInfo = await PackageInfoExtesnion.getPackageInfo();
    // String v1 = '1.2.3', v2 = '1.2.11';
    int v1Number = _getExtendedVersionNumber(packageInfo.version); // return 10020003
    int v2Number = _getExtendedVersionNumber(business.updateApp.version); // return 10020011
    return v2Number > v1Number;
  }

  int _getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }
}
