import 'package:flutter/material.dart';
import 'package:phosart/common/configuration.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/pages/setting/widgets/unlock_premium.dart';
import 'package:phosart/widgets/base/ad_view.dart';
import 'package:phosart/widgets/base/app_card.dart';
import 'package:phosart/widgets/base/app_layout.dart';
import 'package:phosart/widgets/base/lottie_viewer.dart';
import 'package:phosart/widgets/base/separated_list_view.dart';
import 'package:phosart/widgets/base/tile_row.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  _showRatePopup(BuildContext context) {}
  _showSharePopup(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: 'Setting',
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      scroll: true,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.instance.pageBackground),
          fit: BoxFit.cover,
        ),
      ),
      after: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Version ${Configuration.instance.businessConfig.version}', style: Theme.of(context).textTheme.bodyText1),
          LottieViewer(
            lottie: AppAssets.instance.heartTeam,
            width: AppDimensions.instance.icon,
            height: AppDimensions.instance.icon,
          ),
          Text('${Configuration.instance.businessConfig.appName} Team', style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
      children: [
        const UnlockPremium(),
        AppCard(
          child: SeparatedListView.withList(
            separator: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
              child: const Divider(height: 0),
            ),
            list: [
              TileRow.defaultStyle(
                context,
                title: 'Terms of service',
                image: AppAssets.instance.icTerm,
                onTap: (_) {},
              ),
              TileRow.defaultStyle(
                context,
                title: 'FAQ',
                image: AppAssets.instance.icFAQ,
                onTap: (_) {},
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        AppCard(
          child: SeparatedListView.withList(
            separator: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
              child: const Divider(height: 0),
            ),
            list: [
              TileRow.defaultStyle(
                context,
                title: 'Rate us on App Store',
                image: AppAssets.instance.icRate,
                onTap: _showRatePopup,
              ),
              TileRow.defaultStyle(
                context,
                title: 'Share app',
                image: AppAssets.instance.icShare,
                onTap: _showSharePopup,
              )
            ],
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        AppCard(
          child: SeparatedListView.withList(
            separator: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
              child: const Divider(height: 0),
            ),
            list: Configuration.instance.businessConfig.socialNetworks
                .map(
                  (e) => TileRow.defaultStyle(
                    context,
                    title: e.brand,
                    image: e.image,
                    normal: true,
                    onTap: _showRatePopup,
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        const AdView(),
      ],
    );
  }
}
