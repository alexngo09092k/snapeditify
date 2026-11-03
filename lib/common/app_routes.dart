// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
// import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/change_bg/change_bg.dart';
import 'package:snapeditify/pages/fast_editor/fast_editor.dart';
import 'package:snapeditify/pages/make_id_passport/make_id_passport.dart';
import 'package:snapeditify/pages/photos/photos.dart';
import 'package:snapeditify/pages/premium/premium.dart';
import 'package:snapeditify/pages/anime_ai/anime_ai.dart';
import 'package:snapeditify/pages/remove_bg/remove_bg_page.dart';
import 'package:snapeditify/pages/remove_object/remove_object.dart';
import 'package:snapeditify/pages/restore/restore.dart';
import 'package:snapeditify/pages/restyle/restyle.dart';
import 'package:snapeditify/pages/enhance/enhance.dart';
import 'package:snapeditify/pages/albums/albums.dart';
import 'package:snapeditify/pages/home/home.dart';
import 'package:snapeditify/pages/maintenance/maintenance.dart';
import 'package:snapeditify/pages/setting/setting.dart';
import 'package:snapeditify/pages/change_sky/change_sky.dart';
import 'package:snapeditify/pages/splash/splash_page.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
// import 'package:snapeditify/providers/change_bg/change_bg_provider.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/providers/fast_editor/fast_editor_provider.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
// import 'package:snapeditify/providers/make_passport_id/make_passport_id_provider.dart';
// import 'package:snapeditify/providers/remove_bg/remove_bg_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/providers/restore/restore_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/providers/change_sky/change_sky_provider.dart';
import 'package:snapeditify/common/extensions.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';
import 'package:snapeditify/utils/ad_revenue_manager.dart';

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
  static const String albumsPage = 'albums_page';
  static const String photosPage = 'photos_page';
  static const String homePage = 'home_page';
  static const String maintenancePage = 'maintenance_page';
  static const String settingPage = 'setting_page';
  static const String splashPage = 'splash_page';
  static const String removeObjectPage = 'remove_object_page';
  static const String enhanceImagePage = 'enahnce_page';
  static const String restorePage = 'restore_page';
  static const String makeIDPassport = 'make_id_passport';
  static const String removeBG = 'remove_bg';
  static const String changeBG = 'change_bg';
  static const String skyPage = 'sky_page';
  static const String animeAIPage = 'anime_ai_page';
  static const String applyArtEffectPage = 'apply_art_effect_page';
  static const String fastEditor = 'fastEditor';

  static final IAppRoutes _instance = AppRoutes._internal();

  @override
  Map<String, Widget Function(BuildContext)> routes = {
    splashPage: (_) => const SplashPage(),
    maintenancePage: (_) => const MaintenancePage(),
    homePage: (_) => const HomePage(),
    settingPage: (_) => const SettingPage(),
    premiumPage: (_) => const PremiumPage(),
    albumsPage: (_) => const AlbumsPage(),
    removeObjectPage: (_) => const RemoveObjectPage(),
    enhanceImagePage: (_) => const EnhancePage(),
    restorePage: (_) => const RestorePage(),
    makeIDPassport: (_) => const MakeIDPassportPage(),
    applyArtEffectPage: (_) => const RestylePage(),
    skyPage: (_) => const ChangeSkyPage(),
    fastEditor: (_) => const FastEditor(),
    changeBG: (_) => const ChangeBGPage(),
    removeBG: (_) => const RemoveBGPage(),
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
      case makeIDPassport:
        return buildRoute(const MakeIDPassportPage(), settings);
      case removeBG:
        return buildRoute(const RemoveBGPage(), settings);
      case changeBG:
        return buildRoute(const ChangeBGPage(), settings);
      case animeAIPage:
        return buildRoute(const AnimeAIPage(), settings);
      case skyPage:
        return buildRoute(const ChangeSkyPage(), settings);
      case applyArtEffectPage:
        return buildRoute(const RestylePage(), settings);
      case fastEditor:
        return buildRoute(const FastEditor(), settings);
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
    UserPermission.instance.requestStoragePermission(context,
        onHasPermission: () async {
      /// SHOW LOADING POPUP
      LoadingPopup.show();
      try {
        /// LISTEN PHOTOS AND REFRESH GALLERY
        await provider.listenPhotos();
        await provider.refreshGalleryList(true);

        /// Ads: session start / chọn tool (điểm vào funnel cao)
        AdRevenueManager.instance.onSessionStart();
      } finally {
        /// MUST hide BEFORE navigate — hide after push can pop wrong route
        /// or leave loading dialog on top of the new page.
        LoadingPopup.hide();
      }

      /// GO TO ALBUM PAGE (after loading is dismissed)
      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.albumsPage);
      }
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
    final gProvider = ManagerProvider.of<IGalleryProvider>();
    if (imageTool != null) gProvider.imageTool = imageTool;
    UserPermission.instance.requestStoragePermission(
      context,
      onHasPermission: () async {
        final ImageTool current = gProvider.imageTool;
        EditImageProvider? provider;
        String? target;

        /// SHOW LOADING POPUP
        LoadingPopup.show();

        /// CHECK TARGET PAGE
        switch (current) {
          case ImageTool.removeObject:
          case ImageTool.oneTouchRemoveAll:
            provider = ManagerProvider.of<IRemoveObjectProvider>();
            target = AppRoutes.removeObjectPage;
            break;
          case ImageTool.applyArtEffect:
            provider = ManagerProvider.of<IRestyleProvider>();
            target = AppRoutes.applyArtEffectPage;
            break;
          case ImageTool.upscaleImage:
          case ImageTool.enhanceImage:
            provider = ManagerProvider.of<IEnhanceProvider>();
            target = AppRoutes.enhanceImagePage;
            break;
          case ImageTool.restoreOldPhoto:
            provider = ManagerProvider.of<IRestoreProvider>();
            target = AppRoutes.restorePage;
            break;
          case ImageTool.generateAnimeAI:
            provider = ManagerProvider.of<IAnimeAIProvider>();
            target = AppRoutes.animeAIPage;
            break;
          case ImageTool.changeYourSky:
            provider = ManagerProvider.of<IChangeSkyProvider>();
            target = AppRoutes.skyPage;
            break;
          // case ImageTool.makeIDPassportPhoto:
          //   provider = ManagerProvider.of<IMakeIDPassportProvider>();
          //   target = AppRoutes.makeIDPassport;
          //   break;
          // case ImageTool.productPhoto:
          // case ImageTool.changeBG:
          //   provider = ManagerProvider.of<IRemoveBGProvider>();
          //   target = AppRoutes.removeBG;
          //   break;
          case ImageTool.fastEditor:
            provider = ManagerProvider.of<IFastEditorProvider>();
            target = AppRoutes.fastEditor;
            break;
        }

        Future.delayed(const Duration(milliseconds: 100), () async {
          if (provider == null || target == null) {
            LoadingPopup.hide();
            return;
          }
          bool ok = false;
          try {
            /// SET EDIT IMAGE
            ok = await provider.setImage(context, bytes: bytes);
          } finally {
            /// MUST hide BEFORE navigate — hide after push can pop wrong route
            /// or leave loading dialog stuck on the new page.
            LoadingPopup.hide();
          }

          if (!ok || !context.mounted) return;

          if (imageTool != null) {
            Navigator.pushReplacementNamed(context, target!);
          } else {
            Navigator.pushNamed(context, target!);
          }
        });
      },
    );
  }
}
