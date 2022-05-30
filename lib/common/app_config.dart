abstract class AppConfig {
  /// App config
  static String _appName = DefaultConfig.appName;
  static String _appLogo = DefaultConfig.appLogo;
  static double _appVersion = DefaultConfig.appVersion;
  static String _baseUrl = DefaultConfig.baseUrl;
  static String _appColor = DefaultConfig.appColor;
  static String _appTheme = DefaultConfig.appTheme;

  /// Splash screen
  static String _splashImage = DefaultConfig.splashImage;
  static int _splashDuration = DefaultConfig.splashDuration;

  /// Paint config
  static double _strokeWidth = DefaultConfig.strokeWidth;
  static double _minximumStrokeWidth = DefaultConfig.minximumStrokeWidth;
  static double _maximumStrokeWidth = DefaultConfig.maximumStrokeWidth;
  static String _strokeColor = DefaultConfig.strokeColor;
  static double _strokeOpacity = DefaultConfig.strokeOpacity;

  static void setConfig(Map<String, dynamic> value) {
    if (value['appName'] != null) {
      _appName = value['appName'];
    }
    if (value['appLogo'] != null) {
      _appLogo = value['appLogo'];
    }
    if (value['appVersion'] != null) {
      _appVersion = value['appVersion'];
    }
    if (value['baseUrl'] != null) {
      _baseUrl = value['baseUrl'];
    }
    if (value['appColor'] != null) {
      _appColor = value['appColor'];
    }
    if (value['appTheme'] != null) {
      _appTheme = value['appTheme'];
    }
    if (value['splashImage'] != null) {
      _splashImage = value['splashImage'];
    }

    if (value['splashDuration'] != null) {
      _splashDuration = value['splashDuration'];
    }

    if (value['strokeWidth'] != null) {
      _strokeWidth = value['strokeWidth'];
    }

    if (value['minxiumStrokeWidth'] != null) {
      _minximumStrokeWidth = value['minximumStrokeWidth'];
    }

    if (value['maximumStrokeWidth'] != null) {
      _maximumStrokeWidth = value['maximumStrokeWidth'];
    }

    if (value['strokeColor'] != null) {
      _strokeColor = value['strokeColor'];
    }

    if (value['strokeOpacity'] != null) {
      _strokeOpacity = value['strokeOpacity'];
    }
  }

  static String get appName => _appName;

  static String get appLogo => _appLogo;

  static double get appVersion => _appVersion;

  static String get baseUrl => _baseUrl;

  static String get appColor => _appColor;

  static String get appTheme => _appTheme;

  static String get splashImage => _splashImage;

  static int get splashDuration => _splashDuration;

  static double get strokeWidth => _strokeWidth;

  static double get strokeOpacity => _strokeOpacity;

  static String get strokeColor => _strokeColor;

  static double get minximumStrokeWidth => _minximumStrokeWidth;

  static double get maximumStrokeWidth => _maximumStrokeWidth;
}

abstract class DefaultConfig {
  /// App config
  static String appName = 'SnapEdit';
  static String appLogo = 'assets/images/logo.jpg';
  static String baseUrl = '';
  static double appVersion = 1.0;
  static String appColor = '';
  static String appTheme = 'light';

  /// Splash screen
  static String splashImage = 'assets/images/logo.jpg';
  static int splashDuration = 1000; // 1s

  /// Image editor
  static double strokeWidth = 1;
  static double minximumStrokeWidth = 1;
  static double maximumStrokeWidth = 100;
  static String strokeColor = '#9ab065';
  static double strokeOpacity = 0.5;
}
