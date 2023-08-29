import 'package:flutter/cupertino.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/home/widgets/home_base_tools.dart';
import 'package:snapeditify/pages/home/widgets/home_light_dark.dart';
import 'package:snapeditify/pages/home/widgets/home_localizations.dart';
import 'package:snapeditify/pages/home/widgets/home_logo.dart';
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
      children: [
        SizedBox(height: AppDimensions.instance.padding),

        /// REMOVE OBJECTS
        const HomeBaseTools(
          title: 'Remove Objects',
          [ImageTool.removePeople, ImageTool.oneTouchRemoveAll],
          hot: true,
        ),

        SizedBox(height: AppDimensions.instance.padding),

        /// ENHANCE PHOTO
        const HomeBaseTools(title: 'Enhance Photo', [
          ImageTool.enhancePortrait,
          ImageTool.upscaleImage,
          ImageTool.restoreOldPhoto
        ]),

        SizedBox(height: AppDimensions.instance.padding),

        /// CUTOUT OBJECT
        const HomeBaseTools(title: 'Cutout Object', [
          ImageTool.makeIDPassportPhoto,
          ImageTool.productPhoto,
          ImageTool.changeBackground
        ]),

        SizedBox(height: AppDimensions.instance.padding),

        /// ART EFFECT
        const HomeBaseTools(title: 'Art Effect', [
          ImageTool.changeYourSky,
          ImageTool.applyArtEffect,
          ImageTool.createAnimeAI
        ]),

        SizedBox(height: AppDimensions.instance.padding),
        const AdView(),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}
