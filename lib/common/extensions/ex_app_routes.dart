part of '../extensions.dart';

extension AppRoutesUtils on IAppRoutes {
  goRemoveObjectPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.removeObjectPage);
  }

  goEnhanceImagePage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.enhanceImagePage);
  }

  goArtEffectPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.applyArtEffectPage);
  }

  goAllPhotos(BuildContext context, PhotosFor photosFor) {
    ManagerProvider.of<PhotoProvider>().photosFor = photosFor;
    Navigator.of(context).pushNamed(AppRoutes.allPhotosPage);
  }

  goActivePro(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.activeProPage);
  }

  goSetting(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.settingPage);
  }
}
