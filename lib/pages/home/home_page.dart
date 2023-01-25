import 'package:flutter/cupertino.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/home/widgets/home_base_banner.dart';
import 'package:snapeditify/pages/home/widgets/home_logo.dart';
import 'package:snapeditify/pages/home/widgets/home_options.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/ad_view.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottomPadding = AppDimensions.instance.padding * 3;
    return AppLayout(
      back: false,
      appBar: true,
      scroll: true,
      leading: const HomeLogo(),
      action: Padding(
        padding: EdgeInsets.only(right: AppDimensions.instance.padding),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => AppRoutes.instance.goSettingPage(context),
              child: const CustomIcon(CupertinoIcons.square_grid_2x2),
            )
          ],
        ),
      ),
      before: const HomeOptions(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.instance.pageBackground),
          fit: BoxFit.cover,
        ),
      ),
      children: [
        HomeBaseBanner(
          banner: AppAssets.instance.homeRemoveObjectBanner,
          title: 'Turn your\nphotos\ninto Art',
          buttonTitle: 'Try it now',
          action: () => AppRoutes.instance.goGalleryPage(context, EditImageType.removeObject),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        const AdView(),
        HomeBaseBanner(
          banner: AppAssets.instance.homeEnhanceBanner,
          title: 'Turn your\nphotos\ninto Art',
          buttonTitle: 'Try it now',
          action: () => AppRoutes.instance.goGalleryPage(context, EditImageType.enhanceImage),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        const AdView(),
        HomeBaseBanner(
          banner: AppAssets.instance.homeArtEffectBanner,
          title: 'Turn your\nphotos\ninto Art',
          buttonTitle: 'Try it now',
          action: () => AppRoutes.instance.goGalleryPage(context, EditImageType.applyArtEffect),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        const AdView(),
        HomeBaseBanner(
          banner: AppAssets.instance.homeAnimeAIBanner,
          title: 'Turn your\nphotos\ninto Art',
          buttonTitle: 'Try it now',
          action: () => AppRoutes.instance.goGalleryPage(context, EditImageType.animeAI),
        ),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}
