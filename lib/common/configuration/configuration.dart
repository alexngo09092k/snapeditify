part of '../configuration.dart';

class Cofiguration {
  static final Cofiguration _instance = Cofiguration._internal();

  factory Cofiguration() => _instance;

  Cofiguration._internal();

  static FirebaseConfig _firebaseConfig = DefaultConfig.firebaseConfig;
  static ApiConfig _apiConfig = DefaultConfig.apiConfig;
  static AppConfig _appConfig = DefaultConfig.appConfig;
  static AdvertisementConfig _adConfig = DefaultConfig.adConfig;

  static bool _isPutted = false;
  static bool get isPutted => _isPutted;

  static Future<void> setConfig(Map<String, dynamic> value) async {
    if (value['firebaseConfig'] != null) {
      _firebaseConfig = FirebaseConfig.fromMap(value['firebaseConfig']);
    }
    if (value['apiConfig'] != null) {
      _apiConfig = ApiConfig.fromMap(value['apiConfig']);
    }
    if (value['appConfig'] != null) {
      _appConfig = AppConfig.fromMap(value['appConfig']);
    }
    if (value['adConfig'] != null) {
      _adConfig = AdvertisementConfig.fromMap(value['adConfig']);
    }

    _isPutted = true;
  }

  static bool get enableFirebase => _firebaseConfig.enableFirebase;

  static bool get enableCrashAnalytics => _firebaseConfig.enableCrashAnalytics;

  static bool get enableRemoteConfigFirebase => _firebaseConfig.enableRemoteConfigFirebase;

  static AppConfig get appConfig => _appConfig;

  static isNetworkImage(String image) => _appConfig.imageProtocol.any((protocol) => image.startsWith(protocol));

  static FirebaseConfig get firebaseConfig => _firebaseConfig;

  static ApiConfig get apiConfig => _apiConfig;

  static AdvertisementConfig get adConfig => _adConfig;

  final List<String> _listConfigRemoteKey = [
    'adConfig',
    'apiConfig',
    'appConfig',
    'firebaseConfig',
  ];

  void _loadConfig(String key, Map<String, dynamic>? config) async {
    try {
      if (config == null) return;
      switch (key) {
        case 'apiConfig':
          if (config['apiConfig'] != null) {
            _apiConfig = ApiConfig.fromMap(config['apiConfig']);
          }
          break;
        case 'appConfig':
          if (config['appConfig'] != null) {
            _appConfig = AppConfig.fromMap(config['appConfig']);
          }
          break;
        case 'firebaseConfig':
          if (config['firebaseConfig'] != null) {
            _firebaseConfig = FirebaseConfig.fromMap(config['firebaseConfig']);
          }
          break;
        case 'adConfig':
          if (config['adConfig'] != null) {
            _adConfig = AdvertisementConfig.fromMap(config['adConfig']);
          }
          break;
      }
    } catch (error) {
      printLog(error);
    }
  }
}

abstract class DefaultConfig {
  static ApiConfig apiConfig = ApiConfig(
    url: 'https://be-prod-1.snapedit.app',
  );

  static AppConfig appConfig = AppConfig(
    name: 'SnapRetouch',
    version: '1.0',
    primaryColor: '#6C76F1',
    secondaryColor: '#72D5BB',
    logo: AppImages.imgLogoHomeNormal3x,
    homeLogo: AppImages.imgLogoHomeNormal3x,
    splashLogo: AppImages.imgSplashLogoNormal3x,
    imageProtocol: ['https://', 'http://', 'data://'],
    homeBanner: AppImages.homeBanner,
    homeRemoveObjects: [AppImages.homeBefore, AppImages.homeAfter],
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
  Future<bool> loadRemoteConfig() async {
    if(!InternetChecking.singleton.hasConnection){
      return false;
    }
    if (Cofiguration.enableRemoteConfigFirebase) {
      FirebaseRemoteConfig? remoteConfig = Services().firebase.remoteConfig;

      if(remoteConfig == null) return false;

      PackageInfo packageInfo = await PackageInfoExtesnion.getPackageInfo();
      String stringConfig = remoteConfig.getString(packageInfo.packageName.split('.').join());

      Map<String, dynamic> config = json.decode(stringConfig);

      for (var item in _listConfigRemoteKey) {
        _loadConfig(item, config);
      }

    }
    return true;
  }
}

extension PackageInfoExtesnion on Cofiguration {
 static Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String packageName = packageInfo.packageName;

    printLog('APP ID: $packageName');
    printLog('APP NAME $appName');
    printLog('APP VERSION $version');
    printLog('App VERSION CODE $buildNumber');

    return packageInfo;
  }
}