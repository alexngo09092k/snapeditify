// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_scanner/common/configuration.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/utils/widget.dart';
import 'package:qr_scanner/widgets/base/ad_view.dart';
import 'package:qr_scanner/widgets/base/app_card.dart';
import 'package:qr_scanner/widgets/app_use/app_layout.dart';
import 'package:qr_scanner/widgets/base/custom_alert.dart';
import 'package:qr_scanner/widgets/base/lottie_viewer.dart';
import 'package:qr_scanner/widgets/base/separated_list_view.dart';
import 'package:qr_scanner/widgets/base/tile_row.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  _feedback(BuildContext context) {
    mail(BuildContext context) async {
      try {
        final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: Configuration.instance.business.contact,
          query: _encodeQueryParameters({
            'subject':
                'Feedback to ${Configuration.instance.business.appName} Team',
          }),
        );
        if (!await launchUrl(emailLaunchUri)) {
          WidgetUtils.instance.showWarningPopup(
            title: "Feedback",
            message: "Failed to open mail please try again",
            retry: mail,
          );
        }
      } catch (error) {
        Debug.log('FEEDBACK ERROR $error');
        WidgetUtils.instance.showWarningPopup(
          title: "Feedback",
          message: "failed to open mail please try again",
          retry: mail,
        );
      }
    }

    WidgetUtils.instance.alert(
      context,
      title: "Are you happy with ${Configuration.instance.business.appName}?",
      message: "your feed back of the app and provide a better experience",
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
      title: 'Share ${Configuration.instance.business.appName}',
      message: "Lets share one of the best photo editing ppp with",
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
                subject:
                    '${Configuration.instance.business.appName} - ${Configuration.instance.business.appBio}',
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
        WidgetUtils.instance.showWarningPopup(
          title: "Open browser",
          message: "Failed to open browser please try again!",
          retry: (_) => _launchUrlInApp(context, url),
        );
      }
    } catch (error) {
      Debug.log('LUANCH URL ERROR $error');
      WidgetUtils.instance.showWarningPopup(
        title: "Open browser",
        message: "Failed to open browser please try again!",
        retry: (_) => _launchUrlInApp(context, url),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: "Settings",
      scroll: true,
      useScafold: false,
      back: false,
      appBar: true,
      after: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Version ${Configuration.instance.business.version}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          LottieViewer(
            lottie: AppAssets.instance.heartTeam,
            width: AppDimensions.instance.icon,
            height: AppDimensions.instance.icon,
          ),
          Text(
            '${Configuration.instance.business.appName} Team',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
      children: [
        if (Configuration.instance.business.webLinks.isNotEmpty)
          AppCard(
            margin: EdgeInsets.symmetric(
                horizontal: AppDimensions.instance.padding),
            child: SeparatedListView.withList(
              separator: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.instance.padding),
                child: const Divider(height: 0),
              ),
              list: Configuration.instance.business.webLinks
                  .map(
                    (e) => TileRow.defaultStyle(
                      context,
                      title: e.title,
                      image: e.image,
                      onTap: (_) => _launchUrlInApp(context, e.link),
                    ),
                  )
                  .toList(),
            ),
          ),
        if (Configuration.instance.business.webLinks.isNotEmpty)
          SizedBox(height: AppDimensions.instance.padding),
        AppCard(
          margin:
              EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
          child: SeparatedListView.withList(
            separator: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.instance.padding),
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
                title: 'Rate SnapEditify',
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
            margin: EdgeInsets.symmetric(
                horizontal: AppDimensions.instance.padding),
            child: SeparatedListView.withList(
              separator: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.instance.padding),
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
        if (Configuration.instance.business.socialNetworks.isNotEmpty)
          SizedBox(height: AppDimensions.instance.padding),
        const AdView(),
      ],
    );
  }
}
