import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/passport_maker/widgets/passport_bg_color_list.dart';
import 'package:snapeditify/pages/passport_maker/widgets/passport_ratio_list.dart';

class PassportMakerControl extends StatelessWidget {
  const PassportMakerControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AwesomeAppState.screen.height * 1.2 / 5,
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: Column(
        children: [
          Text(
            'Select background color and photo ratio',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: AppDimensions.instance.padding),
          const PassportBGColorList(),
          SizedBox(height: AppDimensions.instance.padding),
          const PassportRatioList(),
        ],
      ),
    );
  }
}
