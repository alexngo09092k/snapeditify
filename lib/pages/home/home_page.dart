import 'package:flutter/material.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/pages/home/widgets/home_ad.dart';
import 'package:phosart/pages/home/widgets/home_base_banner.dart';
import 'package:phosart/pages/home/widgets/home_header.dart';
import 'package:phosart/pages/home/widgets/home_options.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottomPadding = AppDimensions.instance.padding * 3;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.instance.homeBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const HomeHeader(),
              const HomeOptions(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppDimensions.instance.padding),
                  child: Column(
                    children: [
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
      ),
    );
  }
}
