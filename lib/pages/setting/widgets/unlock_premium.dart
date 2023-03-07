import 'package:flutter/material.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

class UnlockPremium extends StatelessWidget {
  const UnlockPremium({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoutes.instance.goPremiumProPage(context),
      child: AppCard(
        margin: EdgeInsets.only(bottom: AppDimensions.instance.padding),
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
                  S.of(context).unlockSnapeditifyPremium,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                Text(
                  S.of(context).noAdsBestImageQuality,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
