import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

class BrushGuide extends StatelessWidget {
  const BrushGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: Navigator.of(context).pop,
        child: LottieViewer(
          lottie: AppAssets.instance.brushAnim,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
