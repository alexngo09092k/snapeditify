import 'package:flutter/material.dart';
// import 'package:fluttering/fluttering.dart';
// import 'package:fluttering_iap/iap/iap.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/app_card.dart';

class PremiumProductList extends StatelessWidget {
  const PremiumProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (_, __) {
          final double width = (__.maxWidth - AppDimensions.instance.paddingX(3)) / 2;
          double height = __.maxHeight > width * 2.5 / 2? width * 2.5 / 2: __.maxHeight - AppDimensions.instance.padding;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _PremiumProduct(key: const Key('0'), width: width, height: height),
              _PremiumProduct(key: const Key('1'), width: width, height: height),
            ],
          );
        },
      ),
    );
  }
}

class _PremiumProduct extends StatelessWidget {
  const _PremiumProduct({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      width: width,
      height: height,
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Titlte', style: Theme.of(context).textTheme.headlineMedium),
          Text('Price', style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
