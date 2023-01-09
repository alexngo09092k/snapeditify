import 'package:phosart/common/configuration.dart';
import 'package:phosart/common/constants.dart';
import 'package:flutter/material.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: AppDimensions.instance.paddingX(1)),
            Text(
              Configuration.instance.businessConfig.maintenanceMode.title,
              style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(width: AppDimensions.instance.padding),
            Text(
              Configuration.instance.businessConfig.maintenanceMode.message,
              style: Theme.of(context).textTheme.bodyText1!,
            ),
            SizedBox(width: AppDimensions.instance.paddingX(1)),
          ],
        ),
      ),
    );
  }
}
