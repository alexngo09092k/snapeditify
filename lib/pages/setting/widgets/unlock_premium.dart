import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_iap/fluttering_iap.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/widgets/base/app_card.dart';
import 'package:phosart/widgets/base/lottie_viewer.dart';

class UnlockPremium extends StatelessWidget {
  const UnlockPremium({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!ManagerProvider.of<AwesomeIAP>().config.enable) return const SizedBox();
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.instance.padding),
      child: AppCard(
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        child: Row(
          children: [
            LottieViewer(
              lottie: AppAssets.instance.premiumGold,
              height: AppDimensions.instance.iconX(1.5),
              width: AppDimensions.instance.iconX(1.5),
            ),
            SizedBox(width: AppDimensions.instance.padding),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Unlock Phosart Premium",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                Text(
                  "No ads & Best image quality",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
