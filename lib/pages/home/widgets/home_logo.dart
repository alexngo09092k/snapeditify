import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:snapedit/common/configuration.dart';

class HomeLogo extends StatelessWidget {
  const HomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          Configuration.instance.businessConfig.appName,
          textStyle: Theme.of(context).textTheme.headline5!,
          colors: [const Color.fromRGBO(108, 118, 241, 1), const Color.fromRGBO(114, 213, 187, 1)],
        ),
      ],
      repeatForever: true,
    );
  }
}
