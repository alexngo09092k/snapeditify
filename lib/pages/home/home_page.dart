import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/pages/home/widgets/home_ad.dart';
import 'package:snapedit/pages/home/widgets/home_art_effect_banner.dart';
import 'package:snapedit/pages/home/widgets/home_float_button.dart';
import 'package:snapedit/pages/home/widgets/home_header.dart';
import 'package:snapedit/pages/home/widgets/home_options.dart';
import 'package:snapedit/pages/home/widgets/home_enhance_banner.dart';
import 'package:snapedit/pages/home/widgets/home_remove_object_banner.dart';
import 'package:snapedit/widgets/unlock_pro_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottomPadding = AppDimensions.instance.padding * 3;
    return Scaffold(
      floatingActionButton: const HomeFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
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
                    const HomeRemoveObjectBanner(),
                    SizedBox(height: AppDimensions.instance.padding),
                    const HomeAd(),
                    SizedBox(height: AppDimensions.instance.padding),
                    const HomeEnhanceBanner(),
                    SizedBox(height: AppDimensions.instance.padding),
                    const UnlockProBanner(),
                    SizedBox(height: AppDimensions.instance.padding),
                    const HomeArtEffectBanner(),
                    SizedBox(height: bottomPadding),
                    const HomeAd(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
