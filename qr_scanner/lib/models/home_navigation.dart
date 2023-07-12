import 'package:qr_scanner/common/constants.dart';

enum HomeNavigation {
  scan,
  generate,
  history,
  settings,
}

extension HomeNavigationEx on HomeNavigation {
  String get icon {
    switch (this) {
      case HomeNavigation.scan:
        return AppAssets.instance.icScanner;
      case HomeNavigation.history:
        return AppAssets.instance.icHistory;
      case HomeNavigation.generate:
        return AppAssets.instance.icGenerate;
      case HomeNavigation.settings:
        return AppAssets.instance.icSettings;
      default:
        throw 'Not found Icon of Home Navigation';
    }
  }

  String get label {
    switch (this) {
      case HomeNavigation.scan:
        return "Scan";
      case HomeNavigation.history:
        return "History";
      case HomeNavigation.generate:
        return "Generate";
      case HomeNavigation.settings:
        return "Settings";
      default:
        throw 'Not found Label of Home Navigation';
    }
  }
}
