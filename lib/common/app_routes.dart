import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snapretouch/pages/edit/edit_page.dart';
import 'package:snapretouch/pages/home/home_page.dart';
import 'package:snapretouch/pages/maintenance/maintenance_page.dart';
import 'package:snapretouch/pages/splash/splash_page.dart';

abstract class AppRoutes {
  static const String homePage = 'home_page';
  static const String editPage = 'edit_page';
  static const String splashPage = 'splash_page';
  static const String maintenancePage = 'maintenance_page';

  static String get initialRoute => splashPage;

  static Map<String, Widget Function(BuildContext)> routes = {
    splashPage: (context) => const SplashPage(),
    homePage: (context) => const HomePage(),
    maintenancePage: (context) => const HomePage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return _buildRoute(const SplashPage(), settings);
      case homePage:
        return _buildRoute(const HomePage(), settings);
      case editPage:
        File image = settings.arguments as File;
        return _buildRoute(EditPage(imagePath: image.path), settings);
      case maintenancePage:
        return _buildRoute(const MaintenancePage(), settings);
      default:
    }
    return null;
  }

  static _buildRoute(Widget page, RouteSettings settings) {
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
