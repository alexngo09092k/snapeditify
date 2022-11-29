import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/constants.dart';
import 'package:fluttering/fluttering.dart';
import 'package:flutter/material.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.instance.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: AppDimensions.instance.paddingSizeLarge),
            Text(
              Configuration.instance.appConfig.maintenanceMode.title,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ThemeProvider.colorByTheme(
                      light: AppColors.instance.kBlack,
                      dark: AppColors.instance.kWhite,
                    ),
                  ),
            ),
            SizedBox(width: AppDimensions.instance.paddingSizeDefault),
            Text(
              Configuration.instance.appConfig.maintenanceMode.message,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: ThemeProvider.colorByTheme(
                      light: AppColors.instance.kBlack,
                      dark: AppColors.instance.kWhite,
                    ),
                  ),
            ),
            SizedBox(width: AppDimensions.instance.paddingSizeLarge),
          ],
        ),
      ),
    );
  }
}
