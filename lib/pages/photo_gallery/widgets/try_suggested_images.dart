import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';

class TrySuggestedImages extends StatelessWidget {
  const TrySuggestedImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimensions.instance.padding),
          child: Row(
            children: [
              Text('Try suggested images', style: Theme.of(context).textTheme.bodyText1),
              Image.asset(
                AppAssets.instance.icStar,
                width: AppDimensions.instance.icon,
              )
            ],
          ),
        )
      ],
    );
  }
}
