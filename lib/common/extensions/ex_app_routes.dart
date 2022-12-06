part of '../extensions.dart';

extension AppRoutesUtils on IAppRoutes {
  goRemoveObjectPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.removeObjectPage);
  }

  goEnhancePage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.enhanceImagePage);
  }

  goArtEffectPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.applyArtEffectPage);
  }

  goGalleryPage(BuildContext context, PhotosFor photosFor) {
    ManagerProvider.of<GalleryProvider>().photosFor = photosFor;
    Navigator.of(context).pushNamed(AppRoutes.galleryPage);
  }

  goPremiumProPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.activeProPage);
  }

  goSettingPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.settingPage);
  }

  goEditPhotoPage(BuildContext context, {required PhotosType type, required String photo}) {
    final PhotosFor photosFor = ManagerProvider.of<GalleryProvider>().photosFor;
    switch (photosFor) {
      case PhotosFor.applyArtEffect:
        goArtEffectPage(context);
        break;
      case PhotosFor.enhanceImage:
        goEnhancePage(context);
        break;
      case PhotosFor.removeObject:
        goRemoveObjectPage(context);
        break;
      default:
        throw ErrorDescription("Not support action");
    }
  }
}
