import 'package:flutter/material.dart';
import 'package:fluttering/utils/logs.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/setting/widgets/unlock_premium.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/base/ad_view.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';
import 'package:snapeditify/widgets/base/separated_list_view.dart';
import 'package:snapeditify/widgets/base/tile_row.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  _showRatePopup(BuildContext context) {}

  _showSharePopup(BuildContext context) {}

  _launchUrlInApp(BuildContext context, String url) async {
    try {
      if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
        WidgetUtils.instance.alert(context, title: '', message: '');
      }
    } catch (error) {
      Debug.log('launchUrlInApp $error');
    }
  }

  _launchUrl(BuildContext context, String url) async {
    try {
      if (!await launchUrl(Uri.parse(url))) {
        WidgetUtils.instance.alert(context, title: '', message: '');
      }
    } catch (error) {
      Debug.log('launchUrl $error');
    }
  }

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
        if (Configuration.instance.businessConfig.webLinks.isNotEmpty)
          AppCard(
            child: SeparatedListView.withList(
              separator: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
                child: const Divider(height: 0),
              ),
              list: Configuration.instance.businessConfig.webLinks
                  .map(
                    (e) => TileRow.defaultStyle(
                      context,
                      title: e.title,
                      image: e.image,
                      normal: true,
                      onTap: (_) => _launchUrlInApp(context, e.link),
                    ),
                  )
                  .toList(),
            ),
          ),
        if (Configuration.instance.businessConfig.webLinks.isNotEmpty) SizedBox(height: AppDimensions.instance.padding),
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
        if (Configuration.instance.businessConfig.socialNetworks.isNotEmpty)
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
                      onTap: (_) => _launchUrl(context, e.link),
                    ),
                  )
                  .toList(),
            ),
          ),
        if (Configuration.instance.businessConfig.socialNetworks.isNotEmpty) SizedBox(height: AppDimensions.instance.padding),
        const AdView(),
      ],
    );
  }
}
