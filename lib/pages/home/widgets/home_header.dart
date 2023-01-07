import 'package:flutter/material.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Configuration.instance.appConfig.appName,
            style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => AppRoutes.instance.goPremiumProPage(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.instance.paddingX(0.5), //// padding small
                    vertical: AppDimensions.instance.paddingX(0.2), //// padding extra small
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.instance.black,
                    borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radiusX(2))), //// radius large
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppAssets.instance.icPro, width: AppDimensions.instance.iconX(0.6)), //// icon small
                      SizedBox(width: AppDimensions.instance.paddingX(0.5)), //// padding small
                      Image.asset(
                        AppAssets.instance.icProText,
                        width: AppDimensions.instance.iconX(0.8), //// icon small
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: AppDimensions.instance.padding),
              GestureDetector(
                onTap: () => AppRoutes.instance.goSettingPage(context),
                child: Image.asset(AppAssets.instance.icMenu, width: AppDimensions.instance.iconX(1)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
