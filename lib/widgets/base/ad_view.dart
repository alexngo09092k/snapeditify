import 'package:flutter/material.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/more_apps.dart';

class AdView extends StatelessWidget {
  const AdView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lottieWidth = screenWidth - AppDimensions.instance.paddingX(2);
    return AdBuilder(
      width: lottieWidth,
      height: lottieWidth * 1 / 3,
      errorBuilder: (_) => MoreApps(height:  lottieWidth * 1 / 3),
      successBuilder: (_, ad) => Padding(
        padding: EdgeInsets.only(bottom: AppDimensions.instance.padding),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
          child: AppCard(child: ad),
        ),
      ),
      borderRadius: BorderRadius.zero,
    );
  }
}
