// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class UnlockPremium extends StatelessWidget {
  const UnlockPremium({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppDimensions.instance.padding),
      child:Configuration.instance.iap.enable? GestureDetector(
        onTap: () => AppRoutes.instance.goPremiumProPage(context),
        child: AppCard(
          margin: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding).copyWith(
            bottom: AppDimensions.instance.padding,
          ),
          child: Container(
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
              image: DecorationImage(
                image: AssetImage(AppAssets.instance.placeholder),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIcon(
                      AppAssets.instance.icPremium,
                      size: AppDimensions.instance.iconX(2),
                      normal: true,
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
                // const CustomIcon(CupertinoIcons.forward),
              ],
            ),
          ),
        ),
      ): const SizedBox(),
    );
  }
}
