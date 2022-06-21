part of '../configuration.dart';

enum CofigurationEvent {
  loadRemoteConfigSuccessed,
  loadRemoteConfigFailed,
  loadLocalRemoteConfigSuccessed,
  loadLocalRemoteConfigFailed,
  loadDefaultConfigSuccessed,
  loadDefaultConfigFailed,
}

class Cofiguration {
  static final Cofiguration _instance = Cofiguration._internal();
  static Cofiguration  get instance => _instance;

  factory Cofiguration() => _instance;

  Cofiguration._internal() {
    _controller = StreamController<CofigurationEvent>();
  }

  late final StreamController<CofigurationEvent> _controller;

  static FirebaseConfig _firebaseConfig = DefaultConfig.firebaseConfig;
  static ApiConfig _apiConfig = DefaultConfig.apiConfig;
  static AppConfig _appConfig = DefaultConfig.appConfig;
  static AdvertisementConfig _adConfig = DefaultConfig.adConfig;

  static bool _isPutted = false;
  static bool get isPutted => _isPutted;

  void setDefaultConfig(Map<String, dynamic> value) {
    printLog('====== SET DEFAULT CONFIG ======');
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

    update(CofigurationEvent.loadDefaultConfigSuccessed);

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

  void _loadConfig(String key, Map<String, dynamic>? config) {
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

  update(CofigurationEvent event) {
    _controller.sink.add(event);
  }

  addListener(Function (CofigurationEvent event) listen) {
    _controller.stream.listen(listen);
  }

  dispose() {
    _controller.close();
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
    logo: AppImages.logo,
    imageProtocol: ['https://', 'http://', 'data://'],
    homeBanner: AppImages.homeBanner,
    homeRemoveObjects: [AppImages.homeBefore, AppImages.homeAfter],
  );

  static FirebaseConfig firebaseConfig = FirebaseConfig(
    enableFirebase: false,
    enableCrashAnalytics: true,
    enableRemoteConfigFirebase: false,
    fetchTimeout: 60, // 1 minutes
    minimumFetchInterval: 60 * 60 * 24 // 1 day
  );

  static AdvertisementConfig adConfig = const AdvertisementConfig(
    enable: false,
    ads: [],
  );
}

extension ConfigurationsFireBaseRemoteConfig on Cofiguration {
   Future<bool> loadRemoteConfig({Function? before}) async {
    bool isExpried = isExpriedRemoteConfig();

    /// if expried, get new remote config
    printLog('remote config expried $isExpried');

    if (isExpried) {
      printLog('====== SET REMOTE CONFIG ======');
      if(before != null) await before();

      FirebaseRemoteConfig? remoteConfig = Services().firebase.remoteConfig;

      if(remoteConfig == null || !AppInternet.instance.hasConnection) {
        update(CofigurationEvent.loadRemoteConfigFailed);
        return false;
      }

      PackageInfo packageInfo = await PackageInfoExtesnion.getPackageInfo();
      String stringConfig = remoteConfig.getString(packageInfo.packageName.split('.').join());
      
      if(stringConfig.isEmpty) {
        update(CofigurationEvent.loadRemoteConfigFailed);
        return false;
      }

      /// setConfig in store
      AppShared.instance.setString(AppSharedKey.remoteConfig, stringConfig);

      Map<String, dynamic> config = json.decode(stringConfig);

      for (var item in _listConfigRemoteKey) {
        _loadConfig(item, config);
      }

      /// miliseconds
      AppShared.instance.setInt(
        AppSharedKey.remoteConfigExpriedDate, 
        (Cofiguration.firebaseConfig.minimumFetchInterval * 1000 + DateTime.now().millisecondsSinceEpoch),
      );

      update(CofigurationEvent.loadRemoteConfigSuccessed);
      return true;
    }

    return loadRemoteConfigFromLocalStore();
  }

  bool loadRemoteConfigFromLocalStore () {
    String? stringConfig = AppShared.instance.getString(AppSharedKey.remoteConfig);
    if(stringConfig == null) {
      update(CofigurationEvent.loadLocalRemoteConfigFailed);
      return false;
    }

    /// enable remote config
    if(!Cofiguration.enableRemoteConfigFirebase) {
      update(CofigurationEvent.loadLocalRemoteConfigFailed);
      return false;
    }

    printLog('====== SET REMOTE CONFIG FROM LOCAL ======');
    Map<String, dynamic> config = json.decode(stringConfig);
    for (var item in _listConfigRemoteKey) {
      _loadConfig(item, config);
    }
    update(CofigurationEvent.loadLocalRemoteConfigSuccessed);
    return true;
  }

  bool isExpriedRemoteConfig () {
    int? timestampExpriedDate = AppShared.instance.getInt(AppSharedKey.remoteConfigExpriedDate);
    int timestampNow = DateTime.now().millisecondsSinceEpoch;
    if(timestampExpriedDate == null || (timestampNow > timestampExpriedDate)) return true;
    return false;
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