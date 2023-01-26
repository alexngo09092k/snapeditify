import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

class EnhanceGuide extends StatelessWidget {
  const EnhanceGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Navigator.of(context).pop,
      child: Center(
        child: LottieViewer(
          lottie: AppAssets.instance.enhanceGuideBfAf,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
