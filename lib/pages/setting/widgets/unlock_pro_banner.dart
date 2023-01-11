import 'package:flutter/material.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/constants.dart';

class UnlockProBanner extends StatelessWidget {
  const UnlockProBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoutes.instance.goPremiumProPage(context),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Image.asset(AppAssets.instance.bgProBanner),
          Padding(
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssets.instance.icProBanner, width: AppDimensions.instance.iconX(2)),
                SizedBox(width: AppDimensions.instance.padding),
                Column(
                  children: [
                    Text(
                      "Unlock SnapEditPro",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                    Text(
                      "No ads & Best image quality",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
