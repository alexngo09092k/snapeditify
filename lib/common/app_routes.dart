import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/pages/edit/edit_page.dart';
import 'package:snapedit/pages/home/home_page.dart';
import 'package:snapedit/pages/splash/splash_page.dart';

abstract class AppRoutes {
  static const String home = '/';
  static const String edit = '/edit';
  static const String splash = '/splash';

  static String get initialRoute => splash;

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => const SplashPage(),
    home: (context) => const HomePage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    printLog('Route ${settings.name} ${settings.arguments}');
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashPage());
      case home:
        return _buildRoute(const HomePage());
      case edit:
        XFile image = settings.arguments as XFile;
        return _buildRoute(EditPage(imagePath: image.path));
      default:
    }
    return null;
  }

  static _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (content) => page);
  }
}
