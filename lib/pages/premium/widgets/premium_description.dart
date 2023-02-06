import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/premium/widgets/premium_product_list.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class PremiumDescription extends StatelessWidget {
  const PremiumDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'It is along It is along',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: AppDimensions.instance.paddingX(2)),
        const _ActiveRow(),
        SizedBox(height: AppDimensions.instance.padding),
        const _ActiveRow(),
        SizedBox(height: AppDimensions.instance.padding),
        const _ActiveRow(),
        SizedBox(height: AppDimensions.instance.padding),
        SizedBox(height: AppDimensions.instance.paddingX(2)),
        const PremiumProductList(),
      ],
    );
  }
}

class _ActiveRow extends StatelessWidget {
  const _ActiveRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomIcon(
          Icons.check_circle,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: AppDimensions.instance.padding),
        Text('It is along', style: Theme.of(context).textTheme.bodyLarge)
      ],
    );
  }
}
