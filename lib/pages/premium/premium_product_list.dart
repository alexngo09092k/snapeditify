// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_local_variable
import 'package:fluttering_iap/fluttering_iap.dart';
import 'package:flutter/material.dart';

import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';

class PremiumProductList extends StatelessWidget {
  const PremiumProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (_, __) {
          final double width =(__.maxWidth - AppDimensions.instance.paddingX(3)) / 2;
          double height = __.maxHeight > width * 2.5 / 2? width * 2.5 / 2: __.maxHeight - AppDimensions.instance.padding;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PremiumProduct(
                width: width,
                height: height,
                onSelect: (product) => {},
                product: IAPProduct(
                  id: '1', 
                  provider: IAPProvider.google, 
                  type: IAPType.subscriptions,
                ),
              ),
              PremiumProduct(
                width: width,
                height: height,
                onSelect: (product) => {},
                product: IAPProduct(
                  id: '1', 
                  provider: IAPProvider.google, 
                  type: IAPType.subscriptions,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PremiumProduct extends StatelessWidget {
  const PremiumProduct({
    Key? key,
    required this.width,
    required this.height,
    required this.onSelect,
    required this.product,
  }) : super(key: key);
  final double width;
  final double height;
  final Function(IAPProduct ) onSelect;
  final IAPProduct product;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      width: width,
      height: height,
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('One month', style: Theme.of(context).textTheme.headlineSmall),
          Text('10.0\$', style: Theme.of(context).textTheme.headlineMedium),
          CustomButton(
            title: "Get it", 
            gradient: AppColors.instance.gradient,
            height: 40,
            // onTap: () => onSelect(product),
          )
        ],
      ),
    );
  }
}
