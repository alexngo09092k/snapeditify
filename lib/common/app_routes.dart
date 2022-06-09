import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snapretouch/pages/edit/edit_page.dart';
import 'package:snapretouch/pages/home/home_page.dart';
import 'package:snapretouch/pages/splash/splash_page.dart';

abstract class AppRoutes {
  static const String home = 'home';
  static const String edit = 'edit';
  static const String splash = 'splash';

  static String get initialRoute => splash;

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => const SplashPage(),
    home: (context) => const HomePage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashPage(), settings);
      case home:
        return _buildRoute(const HomePage(), settings);
      case edit:
        File image = settings.arguments as File;
        return _buildRoute(EditPage(imagePath: image.path), settings);
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
