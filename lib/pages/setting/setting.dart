import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/pages/setting/widgets/rate_popup.dart';
import 'package:snapedit/pages/setting/widgets/share_popup.dart';
import 'package:snapedit/widgets/app_layout.dart';
import 'package:snapedit/widgets/base/block.dart';
import 'package:snapedit/widgets/base/custom_list_tile.dart';
import 'package:snapedit/widgets/base/separated_list_view.dart';
import 'package:snapedit/widgets/unlock_pro_banner.dart';
import 'package:snapedit/widgets/widget.utils.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  _showRatePopup(BuildContext context) => showPopup(context, const RatePopup());
  _showSharePopup(BuildContext context) => showPopup(context, const SharePopup());

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      back: true,
      screen: "Setting",
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      end: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Version 3.1.0', style: Theme.of(context).textTheme.bodyText1),
          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
          // Image.asset(AppAssets.instance.),
          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
          Text('SnapEdit Team', style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
      children: [
        const UnlockProBanner(),
        SizedBox(height: AppDimensions.instance.padding),
        Block(
          child: SeparatedListView.withList(
            separator: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
              child: const Divider(height: 0),
            ),
            list: [
              CustomListTile.defaultStyle(
                context,
                title: 'Rate us on App Store',
                image: AppAssets.instance.icRate,
                onTap: _showRatePopup,
              ),
              CustomListTile.defaultStyle(
                context,
                title: 'Share SnapEdit app',
                image: AppAssets.instance.icShare,
                onTap: _showSharePopup,
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        Block(
          child: SeparatedListView.withList(
            separator: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
              child: const Divider(height: 0),
            ),
            list: [
              CustomListTile.defaultStyle(
                context,
                title: 'Terms of service',
                image: AppAssets.instance.icTerm,
                onTap: (_) {},
              ),
              CustomListTile.defaultStyle(
                context,
                title: 'FAQ',
                image: AppAssets.instance.icFAQ,
                onTap: (_) {},
              ),
              CustomListTile.defaultStyle(
                context,
                title: 'Feedback',
                image: AppAssets.instance.icFeedback,
                onTap: (_) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
