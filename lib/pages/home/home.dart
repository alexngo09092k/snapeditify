import 'package:flutter/material.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/home/widgets/home_base_tools.dart';
import 'package:snapeditify/pages/home/widgets/home_light_dark.dart';
import 'package:snapeditify/pages/home/widgets/home_localizations.dart';
import 'package:snapeditify/pages/home/widgets/home_logo.dart';
import 'package:snapeditify/widgets/app_use/image_tool_list.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = AppDimensions.instance.paddingX(3);

    return AppLayout(
      back: false,
      appBar: true,
      scroll: true,
      leading: const HomeLogo(),
      action: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: AppDimensions.instance.paddingX(0.25)),
          const HomeLocalizations(),
          const HomeLightDarkButton(),
          const HomeSettingsButton(),
          SizedBox(width: AppDimensions.instance.paddingX(0.25)),
        ],
      ),
      before: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimensions.instance.paddingX(0.3),
          6,
          AppDimensions.instance.paddingX(0.3),
          AppDimensions.instance.paddingX(0.2),
        ),
        child: ImageToolList(
          onTool: (e) => AppRoutes.instance.goAlbumsPage(context, e),
        ),
      ),
      children: [
        // Soft hero banner
        Padding(
          padding: EdgeInsets.fromLTRB(
            AppDimensions.instance.padding,
            AppDimensions.instance.paddingX(0.55),
            AppDimensions.instance.padding,
            AppDimensions.instance.paddingX(0.85),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
            decoration: BoxDecoration(
              gradient: AppColors.instance.heroGradient,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: AppColors.brand.withOpacity(isDark ? 0.28 : 0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Soft decorative orbs
                Positioned(
                  right: -22,
                  top: -22,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                Positioned(
                  right: 36,
                  bottom: -28,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.07),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                        ),
                      ),
                      child: Text(
                        'SnapEditify',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      S.of(context).enhancePhoto,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                            height: 1.15,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      S.of(context).removeObjects,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.88),
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        HomeBaseTools(
          title: S.of(context).removeObjects,
          const [
            ImageTool.removeObject,
            ImageTool.oneTouchRemoveAll,
          ],
          hot: true,
        ),

        HomeBaseTools(
          title: S.of(context).enhancePhoto,
          const [
            ImageTool.enhanceImage,
            ImageTool.upscaleImage,
            ImageTool.restoreOldPhoto,
          ],
        ),

        HomeBaseTools(
          title: S.of(context).applyEffects,
          const [
            ImageTool.changeYourSky,
            ImageTool.applyArtEffect,
          ],
        ),

        const AdView(),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}
