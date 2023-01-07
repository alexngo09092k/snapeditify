// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/extensions.dart';
import 'package:snapedit/pages/active_pro/active_pro.dart';
import 'package:snapedit/pages/anime_ai/anime_ai.dart';
import 'package:snapedit/pages/restyle/restyle.dart';
import 'package:snapedit/pages/enhance/enhance.dart';
import 'package:snapedit/pages/gallery/gallery.dart';
import 'package:snapedit/pages/remove_object/remove_object.dart';
import 'package:snapedit/pages/home/home_page.dart';
import 'package:snapedit/pages/maintenance/maintenance_page.dart';
import 'package:snapedit/pages/setting/setting.dart';
import 'package:snapedit/pages/splash/splash_page.dart';
import 'package:snapedit/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';
import 'package:snapedit/providers/gallery/gallery_provider.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/providers/restyle/restyle_provider.dart';

abstract class IAppRoutes {
  String get initialRoute;

  Map<String, Widget Function(BuildContext)> get routes;

  Route<dynamic>? onGenerateRoute(RouteSettings settings);

  Route<dynamic>? buildRoute(Widget page, RouteSettings settings);
}

class AppRoutes extends IAppRoutes {
  factory AppRoutes() => _instance as AppRoutes;

  AppRoutes._internal();

  static const String activeProPage = 'active_pro_page';
  static const String applyArtEffectPage = 'apply_art_effect_page';
  static const String enhanceImagePage = 'enahnce_page';
  static const String galleryPage = 'gallery_page';
  static const String homePage = 'home_page';
  static const String maintenancePage = 'maintenance_page';
  static const String removeObjectPage = 'remove_object_page';
  static const String animeAIPage = 'anime_ai_page';
  static const String settingPage = 'setting_page';
  static const String splashPage = 'splash_page';

  static final IAppRoutes _instance = AppRoutes._internal();

  @override
  Map<String, Widget Function(BuildContext)> routes = {
    splashPage: (context) => const SplashPage(),
    maintenancePage: (context) => const HomePage(),
    homePage: (context) => const HomePage(),
    removeObjectPage: (context) => const RemoveObjectPage(),
    enhanceImagePage: (context) => const EnhancePage(),
    settingPage: (context) => const SettingPage(),
    activeProPage: (context) => const ActiveProPage(),
    applyArtEffectPage: (context) => const RestylePage(),
    galleryPage: (context) => const GalleryPage(),
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
      case removeObjectPage:
        return buildRoute(const RemoveObjectPage(), settings);
      case enhanceImagePage:
        return buildRoute(const EnhancePage(), settings);
      case settingPage:
        return buildRoute(const SettingPage(), settings);
      case activeProPage:
        return buildRoute(const ActiveProPage(), settings);
      case applyArtEffectPage:
        return buildRoute(const RestylePage(), settings);
      case galleryPage:
        return buildRoute(const GalleryPage(), settings);
      case animeAIPage:
        return buildRoute(const AnimeAIPage(), settings);
      default:
        throw ErrorDescription("Not found page");
    }
  }

  static IAppRoutes get instance => _instance;
}

extension AppRoutesUtils on IAppRoutes {
  goGalleryPage(BuildContext context, EditImageType photosFor) {
    ManagerProvider.of<GalleryProvider>().photosFor = photosFor;
    Navigator.of(context).pushNamed(AppRoutes.galleryPage);
  }

  goPremiumProPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.activeProPage);
  }

  goSettingPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.settingPage);
  }

  goEditImagePage(BuildContext context, {required ImageSource type, required Uint8List bytes}) {
    UserPermission.instance.requestStoragePermission(
      onHasPermisson: () async {
        final EditImageType photosFor = ManagerProvider.of<GalleryProvider>().photosFor;
        late final bool res;
        late final String target;

        SmartDialog.showLoading();

        switch (photosFor) {
          case EditImageType.applyArtEffect:
            res = await ManagerProvider.of<RestyleProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.applyArtEffectPage;
            break;
          case EditImageType.enhanceImage:
            res = await ManagerProvider.of<EnhanceProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.enhanceImagePage;
            break;
          case EditImageType.removeObject:
            res = await ManagerProvider.of<RemoveObjectProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.removeObjectPage;
            break;
          case EditImageType.animeAI:
            res = await ManagerProvider.of<AnimeAIProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.animeAIPage;
            break;
          default:
            throw ErrorDescription("Not support action");
        }
        SmartDialog.dismiss();

        if (res) {
          Navigator.of(context).pushNamed(target);
        } else {
          SmartDialog.showToast('Something wrong');
        }
      },
      onNoPermisson: openAppSettings,
    );
  }
}

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  AppRouteObserver({required this.action});

  final Function(String?) action;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
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

  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    action.call(screenName);
    // do something with it, ie. send it to your analytics service collector
  }
}
