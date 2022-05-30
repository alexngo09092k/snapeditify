part of '../configuration.dart';

class Cofiguration {
  static final Cofiguration _instance = Cofiguration._internal();

  factory Cofiguration() => _instance;

  Cofiguration._internal();

  static FirebaseConfig _firebaseConfig = DefaultConfig.firebaseConfig;
  static ApiConfig _apiConfig = DefaultConfig.apiConfig;
  static AppConfig _appConfig = DefaultConfig.appConfig;
  static AdvertisementConfig _adConfig = DefaultConfig.adConfig;

  static Future<void> setConfig(Map<String, dynamic> value) async {
    printLog(value);
    if (value['firebaseConfig'] != null) {
      _firebaseConfig = FirebaseConfig.fromMap(value['firebaseConfig']);
      printLog(_firebaseConfig);
    }
    if (value['apiConfig'] != null) {
      _apiConfig = ApiConfig.fromMap(value['apiConfig']);
    }
    if (value['appConfig'] != null) {
      _appConfig = AppConfig.fromMap(value['appConfig']);
    }
    if(value['adConfig'] != null) {
      _adConfig = AdvertisementConfig.fromMap(value['adConfig']);
    }
  }

  static bool get enableFirebase => _firebaseConfig.enableFirebase;

  static bool get enableCrashAnalytics => _firebaseConfig.enableCrashAnalytics;

  static bool get enableRemoteConfigFirebase => _firebaseConfig.enableRemoteConfigFirebase;

  static String get appName => _appConfig.appName;

  static String get appLogo => _appConfig.appLogo;

  static String get appVersion => _appConfig.appVersion;

  static String get appColor => _appConfig.appColor;

  static String get appTheme => _appConfig.appTheme;

  static FirebaseConfig get firebaseConfig => _firebaseConfig;

  static ApiConfig get apiConfig => _apiConfig;

  static AdvertisementConfig get adConfig => _adConfig;

  final List<String> _listConfigRemoteKey = [
    'apiConfig',
    'appConfig',
    'firebaseConfig',
  ];

  void _loadConfig(String key, FirebaseRemoteConfig remoteConfig) {
    switch (key) {
      case 'apiConfig':
        var data = remoteConfig.getString('apiConfig');
        if (data.isNotEmpty) {
          _apiConfig = ApiConfig.fromJson(data);
        }
        break;
      case 'appConfig':
        final data = remoteConfig.getString('appConfig');
        if (data.isNotEmpty) {
          _appConfig = AppConfig.fromJson(data);
        }
        break;
      case 'firebaseConfig':
        final data = remoteConfig.getString('firebaseConfig');
        if (data.isNotEmpty) {
          _firebaseConfig = FirebaseConfig.fromJson(data);
        }
        break;
      case 'adConfig':
        final data = remoteConfig.getString('adConfig');
        if(data.isNotEmpty) {
          _adConfig = AdvertisementConfig.fromJson(data);
        }
        break;
    }
  }
}

abstract class DefaultConfig {
  static ApiConfig apiConfig = ApiConfig(
    url: '',
    eraseEndPoint: '',
    aiEndPoint: '',
  );

  static AppConfig appConfig = AppConfig(
    appName: '',
    appVersion: '',
    appColor: '',
    appLogo: '',
    appTheme: '',
  );

  static FirebaseConfig firebaseConfig = FirebaseConfig(
    enableFirebase: false,
    enableCrashAnalytics: true,
    enableRemoteConfigFirebase: false,
  );

  static AdvertisementConfig adConfig = const AdvertisementConfig(
    enable: false,
    ads: [],
  );
}

extension ConfigurationsFireBaseRemoteConfig on Cofiguration {
  Future<void> loadRemoteConfig() async {
    if (Cofiguration.enableRemoteConfigFirebase) {
      final remoteConfig = Services().firebase.remoteConfig;
      if (remoteConfig != null) {
        for (var item in _listConfigRemoteKey) {
          _loadConfig(item, remoteConfig);
        }
      }
    }
  }
}
