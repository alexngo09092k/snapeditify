import 'package:flutter/material.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/widgets/base/app_card.dart';

class AdView extends StatelessWidget {
  const AdView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lottieWidth = screenWidth - AppDimensions.instance.padding * 2;
    return AdBuilder(
      width: lottieWidth,
      height: lottieWidth * 1 / 3,
      errorBuilder: (_) => const _AdViewNotFound(),
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

class _AdViewNotFound extends StatelessWidget {
  const _AdViewNotFound();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
