import 'package:flutter/material.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/widgets/app_logo.dart';

class HomeLogo extends StatelessWidget {
  const HomeLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppLogo(
          image: Configuration.instance.appConfig.appLogo,
          height: 40,
        ),
        SizedBox(
          width: AppDimensions.instance.paddingSizeDefault,
        ),
        Text(
          Configuration.instance.appConfig.appName,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
