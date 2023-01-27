// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/pages/photos/photos.dart';
import 'package:snapeditify/pages/premium/premium.dart';
import 'package:snapeditify/pages/anime_ai/anime_ai.dart';
import 'package:snapeditify/pages/restyle/restyle.dart';
import 'package:snapeditify/pages/enhance/enhance.dart';
import 'package:snapeditify/pages/albums/albums.dart';
import 'package:snapeditify/pages/remove_object/remove_object.dart';
import 'package:snapeditify/pages/home/home_page.dart';
import 'package:snapeditify/pages/maintenance/maintenance_page.dart';
import 'package:snapeditify/pages/setting/setting.dart';
import 'package:snapeditify/pages/splash/splash_page.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/common/extensions.dart';
import 'package:snapeditify/utils/widget.dart';

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
  static const String albumsPage = 'albums_page';
  static const String photosPage = 'photos_page';
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
    maintenancePage: (context) => const MaintenancePage(),
    homePage: (context) => const HomePage(),
    removeObjectPage: (context) => const RemoveObjectPage(),
    enhanceImagePage: (context) => const EnhancePage(),
    settingPage: (context) => const SettingPage(),
    activeProPage: (context) => const PremiumPage(),
    applyArtEffectPage: (context) => const RestylePage(),
    albumsPage: (context) => const AlbumsPage(),
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
        return buildRoute(const PremiumPage(), settings);
      case applyArtEffectPage:
        return buildRoute(const RestylePage(), settings);
      case albumsPage:
        return buildRoute(const AlbumsPage(), settings);
      case photosPage:
        return buildRoute(PhotosPage(album: (settings.arguments as AssetPathEntity?)), settings);
      case animeAIPage:
        return buildRoute(const AnimeAIPage(), settings);
      default:
        throw ErrorDescription("Not found page");
    }
  }

  static IAppRoutes get instance => _instance;
}

extension AppRoutesUtils on IAppRoutes {
  goAlbumsPage(BuildContext context, EditImageType editImageType) {
    ManagerProvider.of<GalleryProvider>().editImageType = editImageType;
    Navigator.of(context).pushNamed(AppRoutes.albumsPage);
  }

  goPhotosPage(BuildContext context, {AssetPathEntity? album}) {
    Navigator.of(context).pushNamed(AppRoutes.photosPage, arguments: album);
  }

  goPremiumProPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.activeProPage);
  }

  goSettingPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.settingPage);
  }

  goEditImagePage(BuildContext context, {required Uint8List bytes}) {
    UserPermission.instance.requestStoragePermission(
      context,
      onHasPermisson: () async {
        final EditImageType editImageType = ManagerProvider.of<GalleryProvider>().editImageType;
        late final bool res;
        late final String target;

        WidgetUtils.instance.showLoadingPopup(context, message: 'Please wait a moment!');

        switch (editImageType) {
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

        Navigator.pop(context);

        if (res) {
          Navigator.pushNamed(context, target);
        }
      },
    );
  }
}
