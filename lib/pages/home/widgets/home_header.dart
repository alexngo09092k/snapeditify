import 'package:flutter/material.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/pages/home/widgets/home_logo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HomeLogo(),
          Row(
            children: [
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
