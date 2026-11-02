import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class PremiumDescription extends StatelessWidget {
  const PremiumDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          s.unlockPremium,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: AppDimensions.instance.paddingX(2)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ActiveRow(title: s.unlimitedAccessAiFeatures),
            SizedBox(height: AppDimensions.instance.padding),
            _ActiveRow(title: s.noAdsBestExperience),
            SizedBox(height: AppDimensions.instance.padding),
            _ActiveRow(title: s.bestOutputImageQuality),
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
        SizedBox(width: AppDimensions.instance.paddingX(0.5)),
        Flexible(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
