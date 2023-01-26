import 'package:flutter/material.dart';
import 'package:fluttering/utils/logs.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/setting/widgets/unlock_premium.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/base/ad_view.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/custom_alert.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';
import 'package:snapeditify/widgets/base/separated_list_view.dart';
import 'package:snapeditify/widgets/base/tile_row.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  _feedback(BuildContext context) {
    mail(BuildContext context) async {
      try {
        final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: Configuration.instance.business.contact,
          query: _encodeQueryParameters({
            'subject': 'Feedback to ${Configuration.instance.business.appName} Team',
          }),
        );
        if (!await launchUrl(emailLaunchUri)) {
          WidgetUtils.instance.showErrorPopup(context, retry: mail);
        }
      } catch (error) {
        Debug.log('feedback $error');
        WidgetUtils.instance.showErrorPopup(context, retry: mail);
      }
    }

    WidgetUtils.instance.alert(
      context,
      title: "Are you happy with\n${Configuration.instance.business.appName}?",
      message: "Your feedback of the app and provide a better experience",
      actions: [
        AlertAction(
          title: "Cancel",
          isDestructiveAction: true,
          onPressed: Navigator.of(context).pop,
        ),
        AlertAction(
          title: "Send",
          onPressed: () async {
            Navigator.of(context).pop();
            mail(context);
          },
        ),
      ],
    );
  }

  _showSharePopup(BuildContext context) {
    WidgetUtils.instance.alert(
      context,
      title: "Share ${Configuration.instance.business.appName}",
      message: "Let's share one of the best photo editing app with your friends, family and community",
      actions: [
        AlertAction(
          title: "Cancel",
          isDestructiveAction: true,
          onPressed: Navigator.of(context).pop,
        ),
        AlertAction(
          title: "Share",
          onPressed: () {
            Navigator.of(context).pop();
            if (Configuration.instance.business.shareApp.link != null) {
              Share.share(
                Configuration.instance.business.shareApp.link!,
                subject: Configuration.instance.business.appName,
              );
            }
          },
        ),
      ],
    );
  }

  _launchUrlInApp(BuildContext context, String url) async {
    try {
      if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
        WidgetUtils.instance.showErrorPopup(context, retry: (_) => _launchUrlInApp(context, url));
      }
    } catch (error) {
      Debug.log('launchUrlInApp $error');
      WidgetUtils.instance.showErrorPopup(context, retry: (_) => _launchUrlInApp(context, url));
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
          Text('Version ${Configuration.instance.business.version}', style: Theme.of(context).textTheme.bodyText1),
          LottieViewer(
            lottie: AppAssets.instance.heartTeam,
            width: AppDimensions.instance.icon,
            height: AppDimensions.instance.icon,
          ),
          Text('${Configuration.instance.business.appName} Team', style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
      children: [
        const UnlockPremium(),
        if (Configuration.instance.business.webLinks.isNotEmpty)
          AppCard(
            child: SeparatedListView.withList(
              separator: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
                child: const Divider(height: 0),
              ),
              list: Configuration.instance.business.webLinks
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
        if (Configuration.instance.business.webLinks.isNotEmpty) SizedBox(height: AppDimensions.instance.padding),
        AppCard(
          child: SeparatedListView.withList(
            separator: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
              child: const Divider(height: 0),
            ),
            list: [
              TileRow.defaultStyle(
                context,
                title: 'Feedback',
                image: AppAssets.instance.icFeedback,
                onTap: _feedback,
              ),
              TileRow.defaultStyle(
                context,
                title: 'Share ${Configuration.instance.business.appName}',
                image: AppAssets.instance.icShare,
                onTap: _showSharePopup,
              )
            ],
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        if (Configuration.instance.business.socialNetworks.isNotEmpty)
          AppCard(
            child: SeparatedListView.withList(
              separator: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
                child: const Divider(height: 0),
              ),
              list: Configuration.instance.business.socialNetworks
                  .map(
                    (e) => TileRow.defaultStyle(
                      context,
                      title: e.brand,
                      image: e.image,
                      normal: true,
                      onTap: (_) => _launchUrlInApp(context, e.link),
                    ),
                  )
                  .toList(),
            ),
          ),
        if (Configuration.instance.business.socialNetworks.isNotEmpty) SizedBox(height: AppDimensions.instance.padding),
        const AdView(),
      ],
    );
  }
}
