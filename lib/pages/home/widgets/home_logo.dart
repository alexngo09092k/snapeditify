import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';

class HomeLogo extends StatelessWidget {
  const HomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppDimensions.instance.padding),
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            Configuration.instance.businessConfig.appName,
            textStyle: Theme.of(context).textTheme.headline5!,
            colors: [Theme.of(context).primaryColor, Theme.of(context).colorScheme.secondary],
          ),
        ],
        repeatForever: true,
      ),
    );
  }
}
