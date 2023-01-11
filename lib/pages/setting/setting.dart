import 'package:flutter/material.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/widgets/base/app_layout.dart';
import 'package:phosart/widgets/base/tile_row.dart';
import 'package:phosart/widgets/base/separated_list_view.dart';
import 'package:phosart/pages/setting/widgets/unlock_pro_banner.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  _showRatePopup(BuildContext context) {}
  _showSharePopup(BuildContext context) {}

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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radiusX(1))),
            color: Theme.of(context).cardColor,
          ),
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
                title: 'Share SnapEdit app',
                image: AppAssets.instance.icShare,
                onTap: _showSharePopup,
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radiusX(1))),
            color: Theme.of(context).cardColor,
          ),
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
              TileRow.defaultStyle(
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
