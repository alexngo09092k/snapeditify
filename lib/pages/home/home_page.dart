import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/pages/home/widgets/home_ad.dart';
import 'package:snapedit/pages/home/widgets/home_base_banner.dart';
import 'package:snapedit/pages/home/widgets/home_header.dart';
import 'package:snapedit/pages/home/widgets/home_options.dart';
import 'package:snapedit/providers/gallery/gallery_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottomPadding = AppDimensions.instance.padding * 3;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.instance.homeBg, width: AwesomeAppState.screen.width, height: AwesomeAppState.screen.height),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const HomeHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(AppDimensions.instance.padding),
                    child: Column(
                      children: [
                        const HomeOptions(),
                        SizedBox(height: AppDimensions.instance.padding),
                        HomeBaseBanner(
                          banner: AppAssets.instance.homeRemoveObjectBanner,
                          title: 'Turn your\nphotos\ninto Art',
                          buttonTitle: 'Try it now',
                          action: () => AppRoutes.instance.goGalleryPage(context, EditImageType.removeObject),
                        ),
                        SizedBox(height: AppDimensions.instance.padding),
                        const HomeAd(),
                        SizedBox(height: AppDimensions.instance.padding),
                        HomeBaseBanner(
                          banner: AppAssets.instance.homeEnhanceBanner,
                          title: 'Turn your\nphotos\ninto Art',
                          buttonTitle: 'Try it now',
                          action: () => AppRoutes.instance.goGalleryPage(context, EditImageType.enhanceImage),
                        ),
                        SizedBox(height: AppDimensions.instance.padding),
                        const HomeAd(),
                        SizedBox(height: AppDimensions.instance.padding),
                        HomeBaseBanner(
                          banner: AppAssets.instance.homeArtEffectBanner,
                          title: 'Turn your\nphotos\ninto Art',
                          buttonTitle: 'Try it now',
                          action: () => AppRoutes.instance.goGalleryPage(context, EditImageType.applyArtEffect),
                        ),
                        SizedBox(height: AppDimensions.instance.padding),
                        const HomeAd(),
                        SizedBox(height: AppDimensions.instance.padding),
                        HomeBaseBanner(
                          banner: AppAssets.instance.homeAnimeAIBanner,
                          title: 'Turn your\nphotos\ninto Art',
                          buttonTitle: 'Try it now',
                          action: () => AppRoutes.instance.goGalleryPage(context, EditImageType.animeAI),
                        ),
                        SizedBox(height: bottomPadding),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
