import 'package:flutter/material.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/widgets/base/app_card.dart';

class SettingAd extends StatelessWidget {
  const SettingAd({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lottieWidth = screenWidth - AppDimensions.instance.padding * 2;
    return AppCard(
      child: AdBuilder(
        width: lottieWidth,
        height: lottieWidth * 1 / 3,
        errorBuilder: (_) => const _SettingAdNotFound(),
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
      ),
    );
  }
}

class _SettingAdNotFound extends StatelessWidget {
  const _SettingAdNotFound();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
