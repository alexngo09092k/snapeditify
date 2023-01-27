import 'package:flutter/material.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class HomeLogo extends StatelessWidget {
  const HomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppDimensions.instance.padding),
        CustomImage(
          image: Configuration.instance.business.appLogo,
          width: AppDimensions.instance.iconX(1.5),
          height: AppDimensions.instance.iconX(1.5),
        ),
        SizedBox(width: AppDimensions.instance.paddingX(0.5)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Configuration.instance.business.appName,
              style: Theme.of(context).textTheme.headline5!,
            ),
            Text(
              Configuration.instance.business.appBio,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ],
    );
  }
}
