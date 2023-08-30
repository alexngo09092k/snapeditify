// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/create_id_photo/create_id_photo.dart';
import 'package:snapeditify/pages/photos/photos.dart';
import 'package:snapeditify/pages/premium/premium.dart';
import 'package:snapeditify/pages/anime_ai/anime_ai.dart';
import 'package:snapeditify/pages/remove_object/remove_object.dart';
import 'package:snapeditify/pages/restore/restore.dart';
import 'package:snapeditify/pages/restyle/restyle.dart';
import 'package:snapeditify/pages/enhance/enhance.dart';
import 'package:snapeditify/pages/albums/albums.dart';
import 'package:snapeditify/pages/home/home_page.dart';
import 'package:snapeditify/pages/maintenance/maintenance_page.dart';
import 'package:snapeditify/pages/setting/setting.dart';
import 'package:snapeditify/pages/sky/sky.dart';
import 'package:snapeditify/pages/splash/splash_page.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/providers/edit_background/edit_background_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/providers/restore/restore_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/providers/sky/sky_provider.dart';
import 'package:snapeditify/common/extensions.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

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
  static const String skyPage = 'sky_page';
  static const String restorePage = 'restore_page';

  /// Features
  static const String createIDPhoto = 'create_id_photo_page';

  static final IAppRoutes _instance = AppRoutes._internal();

  @override
  Map<String, Widget Function(BuildContext)> routes = {
    splashPage: (_) => const SplashPage(),
    maintenancePage: (_) => const MaintenancePage(),
    homePage: (_) => const HomePage(),
    settingPage: (_) => const SettingPage(),
    premiumPage: (_) => const PremiumPage(),
    albumsPage: (_) => const AlbumsPage(),
    enhanceImagePage: (_) => const EnhancePage(),
    applyArtEffectPage: (_) => const RestylePage(),
    restorePage: (_) => const RestorePage(),
    skyPage: (_) => const SkyPage(),

    /// Features
    removeObjectPage: (_) => const RemoveObjectPage(),
    createIDPhoto: (_) => const CreateIDPhotoPage(),
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
        return buildRoute(const SettingPage(), settings);
      case premiumPage:
        return buildRoute(const PremiumPage(), settings);
      case albumsPage:
        return buildRoute(const AlbumsPage(), settings);
      case photosPage:
        return buildRoute(PhotosPage(albumId: (settings.arguments as String?)), settings);
      case removeObjectPage:
        return buildRoute(const RemoveObjectPage(), settings);
      case enhanceImagePage:
        return buildRoute(const EnhancePage(), settings);
      case restorePage: 
        return buildRoute(const RestorePage(), settings);
      case createIDPhoto: 
        return buildRoute(const CreateIDPhotoPage(), settings);
      case animeAIPage:
        return buildRoute(const AnimeAIPage(), settings);
      case skyPage:
        return buildRoute(const SkyPage(), settings);
      case applyArtEffectPage:
        return buildRoute(const RestylePage(), settings);
      default:
        throw ErrorDescription("Not found page");
    }
  }

  static IAppRoutes get instance => _instance;
}

extension AppRoutesUtils on IAppRoutes {
  void goAlbumsPage(BuildContext context, ImageTool imageTool) {
    final provider = ManagerProvider.of<GalleryProvider>();
    provider.imageTool = imageTool;
    UserPermission.instance.requestStoragePermission(context, onHasPermisson: () async {
      /// SHOW LOADING POPUP
      LoadingPopup.show(S.of(context).pleaseWaitAMoment);

      /// LISTEN PHOTOS AND REFRESH GALLERY
      await provider.listenPhotos();
      await provider.refreshGalleryList(true);

      /// HIDE LOADING
      LoadingPopup.hide();

      /// GO TO ALBUM PAGE
      Navigator.pushNamed(context, AppRoutes.albumsPage);
    });
  }

  void goPhotosPage(BuildContext context, {String? albumId}) {
    Navigator.pushNamed(context, AppRoutes.photosPage, arguments: albumId);
  }

  void goPremiumProPage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.premiumPage);
  }

  void goSettingPage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settingPage);
  }

  void goEditImagePage(BuildContext context, {required Uint8List bytes, ImageTool? imageTool}) {
    final provider = ManagerProvider.of<GalleryProvider>();
    if (imageTool != null) provider.imageTool = imageTool;
    UserPermission.instance.requestStoragePermission(
      context,
      onHasPermisson: () async {
        final ImageTool current = provider.imageTool;
        late final bool res;
        late final String target;

        /// SHOW LOADING POPUP
        LoadingPopup.show(S.of(context).pleaseWaitAMoment);

        /// CHECK TARGET PAGE
        switch (current) {
          case ImageTool.removePeople:
          case ImageTool.oneTouchRemoveAll:
            res = await ManagerProvider.of<RemoveObjectProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.removeObjectPage;
            break;
          case ImageTool.applyArtEffect:
            res = await ManagerProvider.of<RestyleProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.applyArtEffectPage;
            break;
          case ImageTool.enhancePortrait:
            res = await ManagerProvider.of<EnhanceProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.enhanceImagePage;
            break;
          case ImageTool.restoreOldPhoto:
            res = await ManagerProvider.of<RestoreProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.restorePage;
            break;
          case ImageTool.createAnimeAI:
            res = await ManagerProvider.of<AnimeAIProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.animeAIPage;
            break;
          case ImageTool.changeYourSky:
            res = await ManagerProvider.of<SkyProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.skyPage;
            break;
          case ImageTool.makeIDPassportPhoto:
            res = await ManagerProvider.of<EditBackgroundProvider>().setImage(context, bytes: bytes);
            target = AppRoutes.createIDPhoto;
            break;
          default:
            break;
        }

        /// HIDE LOADING
        LoadingPopup.hide();

        if (res) {
          if (imageTool != null) {
            Navigator.pushReplacementNamed(context, target);
          } else {
            Navigator.pushNamed(context, target);
          }
        }
      },
    );
  }
}
