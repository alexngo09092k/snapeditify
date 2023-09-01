import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class PremiumDescription extends StatelessWidget {
  const PremiumDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Unlock Premium',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: AppDimensions.instance.paddingX(2)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ActiveRow(title: 'Unlimited access to powerful AI features'),
            SizedBox(height: AppDimensions.instance.padding),
            const _ActiveRow(title: 'No ads - enjoy the best experience'),
            SizedBox(height: AppDimensions.instance.padding),
            const _ActiveRow(title: 'Best output image quality'),
          ],
        )
      ],
    );
  }
}

class _ActiveRow extends StatelessWidget {
  const _ActiveRow({
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIcon(
          Icons.check_circle,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: AppDimensions.instance.padding),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
