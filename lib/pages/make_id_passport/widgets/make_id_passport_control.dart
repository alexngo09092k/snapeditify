import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/make_id_passport/widgets/id_passport_bg_color_list.dart';
import 'package:snapeditify/pages/make_id_passport/widgets/id_passport_ratio_list.dart';

class MakePassportIDControl extends StatelessWidget {
  const MakePassportIDControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AwesomeAppState.screen.height * 1.2 / 5,
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: Column(
        children: [
          Text(
            S.of(context).selectBackgroundColorAndPhotoRatio,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: AppDimensions.instance.padding),
          const PassportIDBGColorList(),
          SizedBox(height: AppDimensions.instance.padding),
          const PassportIDRatioList(),
        ],
      ),
    );
  }
}
