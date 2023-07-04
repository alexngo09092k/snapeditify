import 'package:flutter/material.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class HomeSettingsButton extends StatelessWidget {
  const HomeSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoutes.instance.goSettingPage(context),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.5)),
        child: const CustomIcon(Icons.settings_outlined),
      ),
    );
  }
}
