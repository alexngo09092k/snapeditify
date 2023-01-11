import 'package:flutter/material.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:phosart/common/constants.dart';

class HomeAd extends StatelessWidget {
  const HomeAd({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lottieWidth = screenWidth - AppDimensions.instance.padding * 2;
    return AdBuilder(
      width: lottieWidth,
      height: lottieWidth * 1 / 3,
      errorBuilder: (_) => const SizedBox(
        child: Text("hELLO"),
      ),
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
    );
  }
}
