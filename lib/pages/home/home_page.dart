import 'package:flutter/cupertino.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/home/widgets/home_base_banner.dart';
import 'package:snapeditify/pages/home/widgets/home_light_dark.dart';
import 'package:snapeditify/pages/home/widgets/home_localizations.dart';
import 'package:snapeditify/pages/home/widgets/home_logo.dart';
import 'package:snapeditify/pages/home/widgets/home_options.dart';
import 'package:snapeditify/pages/home/widgets/home_settings_button.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/ad_view.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
    Configuration.instance.checkAppUpdate();
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = AppDimensions.instance.paddingX(3);
    return AppLayout(
      back: false,
      appBar: true,
      scroll: true,
      leading: const HomeLogo(),
      action: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
          const HomeLocalizations(),
          const HomeLightDarkButton(), 
          const HomeSettingsButton(),
          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
        ],
      ),
      before: const HomeOptions(),
      children: [
        SizedBox(height: AppDimensions.instance.padding),
        HomeBaseBanner(
          banner: AppAssets.instance.homeAnimeAIBanner,
          title: S.of(context).createNanimeAvatar,
          buttonTitle: S.of(context).tryItNow,
          action: () => AppRoutes.instance.goAlbumsPage(context, EditImageType.animeAI),
        ),
        const AdView(),
        HomeBaseBanner(
          banner: AppAssets.instance.homeEnhanceBanner,
          title: S.of(context).enhanceNimageQuality,
          buttonTitle: S.of(context).tryItNow,
          action: () => AppRoutes.instance.goAlbumsPage(context, EditImageType.enhanceImage),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        HomeBaseBanner(
          banner: AppAssets.instance.homeRemoveObjectBanner,
          title: S.of(context).removeThingsNfromImage,
          buttonTitle: S.of(context).tryItNow,
          action: () => AppRoutes.instance.goAlbumsPage(context, EditImageType.removeObject),
        ),
       const AdView(),
        HomeBaseBanner(
          banner: AppAssets.instance.homeArtEffectBanner,
          title: S.of(context).turnYourNimageNintoArt,
          buttonTitle: S.of(context).tryItNow,
          action: () => AppRoutes.instance.goAlbumsPage(context, EditImageType.applyArtEffect),
        ),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}
