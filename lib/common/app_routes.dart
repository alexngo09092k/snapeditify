import 'package:flutter/material.dart';
import 'package:snapedit/pages/active_pro/active_pro.dart';
import 'package:snapedit/pages/all_photos/all_photos.dart';
import 'package:snapedit/pages/apply_art_effect/apply_art_effect.dart';
import 'package:snapedit/pages/enhance_image/enhance_image.dart';
import 'package:snapedit/pages/remove_object/remove_object.dart';
import 'package:snapedit/pages/home/home_page.dart';
import 'package:snapedit/pages/maintenance/maintenance_page.dart';
import 'package:snapedit/pages/setting/setting.dart';
import 'package:snapedit/pages/splash/splash_page.dart';

abstract class IAppRoutes {
  String get initialRoute;

  Map<String, Widget Function(BuildContext)> get routes;

  Route<dynamic>? onGenerateRoute(RouteSettings settings);

  Route<dynamic>? buildRoute(Widget page, RouteSettings settings);
}

class AppRoutes extends IAppRoutes {
  static final IAppRoutes _instance = AppRoutes._internal();
  static IAppRoutes get instance => _instance;

  factory AppRoutes() => _instance as AppRoutes;
  AppRoutes._internal();

  static const String splashPage = 'splash_page';
  static const String maintenancePage = 'maintenance_page';
  static const String homePage = 'home_page';
  static const String removeObjectPage = 'remove_object_page';
  static const String enhanceImagePage = 'enahnce_image_page';
  static const String settingPage = 'setting_page';
  static const String activeProPage = 'active_pro_page';
  static const String applyArtEffectPage = 'apply_art_effect_page';
  static const String allPhotosPage = 'all_photos_page';

  @override
  String get initialRoute => splashPage;

  @override
  Map<String, Widget Function(BuildContext)> routes = {
    splashPage: (context) => const SplashPage(),
    maintenancePage: (context) => const HomePage(),
    homePage: (context) => const HomePage(),
    removeObjectPage: (context) => const RemoveObjectPage(),
    enhanceImagePage: (context) => const EnhanceImagePage(),
    settingPage: (context) => const SettingPage(),
    activeProPage: (context) => const ActiveProPage(),
    applyArtEffectPage: (context) => const ApplyArtEffectPage(),
    allPhotosPage: (context) => const AllPhotosPage(),
  };

  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return buildRoute(const SplashPage(), settings);
      case maintenancePage:
        return buildRoute(const MaintenancePage(), settings);
      case homePage:
        return buildRoute(const HomePage(), settings);
      case removeObjectPage:
        return buildRoute(const RemoveObjectPage(), settings);
      case enhanceImagePage:
        return buildRoute(const EnhanceImagePage(), settings);
      case settingPage:
        return buildRoute(const SettingPage(), settings);
      case activeProPage:
        return buildRoute(const ActiveProPage(), settings);
      case applyArtEffectPage:
        return buildRoute(const ApplyArtEffectPage(), settings);
      case allPhotosPage:
        return buildRoute(const AllPhotosPage(), settings);
      default:
        throw ErrorDescription("Not found page");
    }
  }

  @override
  buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (content) => page, settings: settings);
  }
}

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final Function(String?) action;
  AppRouteObserver({required this.action});

  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    action.call(screenName);
    // do something with it, ie. send it to your analytics service collector
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}
