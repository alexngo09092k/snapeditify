// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_data.dart';
import 'package:qr_scanner/pages/generate/generate_page.dart';
import 'package:qr_scanner/pages/history/history_page.dart';
import 'package:qr_scanner/pages/home/home_page.dart';
import 'package:qr_scanner/pages/maintenance_page.dart';
import 'package:qr_scanner/pages/premium_page.dart';
import 'package:qr_scanner/pages/scanner/scanner_page.dart';
import 'package:qr_scanner/pages/settings/settings_page.dart';
import 'package:qr_scanner/pages/splash_page.dart';
import 'package:qr_scanner/pages/viewer_page.dart';

abstract class IAppRoutes {
  String get initialRoute;

  Map<String, Widget Function(BuildContext)> get routes;

  Route<dynamic>? onGenerateRoute(RouteSettings settings);

  Route<dynamic>? buildRoute(Widget page, RouteSettings settings);
}

class AppRoutes extends IAppRoutes {
  factory AppRoutes() => _instance as AppRoutes;

  AppRoutes._internal();

  static const String premiumPage = 'premium_page';
  static const String homePage = 'home_page';
  static const String maintenancePage = 'maintenance_page';
  static const String settingPage = 'setting_page';
  static const String splashPage = 'splash_page';
  static const String generatePage = 'generate_page';
  static const String historyPage = 'history_page';
  static const String scannerPage = 'scanner_page';
  static const String viewerPage = 'viewer_page';

  static final IAppRoutes _instance = AppRoutes._internal();

  @override
  Map<String, Widget Function(BuildContext)> routes = {
    splashPage: (_) => const SplashPage(),
    maintenancePage: (_) => const MaintenancePage(),
    homePage: (_) => const HomePage(),
    settingPage: (_) => const SettingsPage(),
    premiumPage: (_) => const PremiumPage(),
    generatePage: (_) => const GeneratePage(),
    historyPage: (_) => const HistoryPage(),
    scannerPage: (_) => const ScannerPage(),
  };

  @override
  buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (content) => page, settings: settings);
  }

  @override
  String get initialRoute => splashPage;

  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return buildRoute(const SplashPage(), settings);
      case maintenancePage:
        return buildRoute(const MaintenancePage(), settings);
      case homePage:
        return buildRoute(const HomePage(), settings);
      case settingPage:
        return buildRoute(const SettingsPage(), settings);
      case generatePage:
        return buildRoute(const GeneratePage(), settings);
      case historyPage:
        return buildRoute(const HistoryPage(), settings);
      case scannerPage:
        return buildRoute(const ScannerPage(), settings);
      case viewerPage:
        final QRData qrData = settings.arguments as QRData;
        return buildRoute(ViewerPage(qrData), settings);
      default:
        throw ErrorDescription("Not found page");
    }
  }

  static IAppRoutes get instance => _instance;
}
