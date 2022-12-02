import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';

class HomeAd extends StatelessWidget {
  const HomeAd({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lottieWidth = screenWidth - AppDimensions.instance.padding * 2;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.padding)),
      child: Container(
        width: lottieWidth,
        height: (lottieWidth * 2 / 3) * 2 / 3,
        color: Colors.red,
      ),
    );
  }
}
