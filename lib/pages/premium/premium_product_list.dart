// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_local_variable
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_iap/fluttering_iap.dart';
import 'package:flutter/material.dart';

import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';

class PremiumProductList extends StatelessWidget {
  const PremiumProductList({super.key});

  Future<void> _buy(IAPProduct product) async {
   final IAwesomeIAP provider = ManagerProvider.of<IAwesomeIAP>();
   await provider.purchase(product);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (_, __) {
        final double width =(__.maxWidth - AppDimensions.instance.paddingX(3)) / 2;
        double height = __.maxHeight > width * 2.5 / 2? width * 2.5 / 2: __.maxHeight - AppDimensions.instance.padding;
        return PropConsumer<IAwesomeIAP, List<IAPProduct>>(
          select: (_) => _.products.where((element) => element.info != null).toList(),
          builder: (_, child, ___, products) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: products.map((e) {
                return PremiumProduct(
                  width: width,
                  height: height,
                  onSelect: _buy,
                  product: e,
                );
              }).toList(),
            );
          },
        );
      }),
    );
  }
}

class PremiumProduct extends StatelessWidget {
  const PremiumProduct({
    super.key,
    required this.width,
    required this.height,
    required this.onSelect,
    required this.product,
  });
  final double width;
  final double height;
  final Function(IAPProduct) onSelect;
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
          Text(product.info!.name, style: Theme.of(context).textTheme.headlineSmall, maxLines: 1),
          Text(product.info!.price, style: Theme.of(context).textTheme.headlineMedium, maxLines: 1,),
          Text(product.info!.description, style: Theme.of(context).textTheme.bodyLarge, maxLines: 3,),
          CustomButton(
            title: "Get it",
            gradient: AppColors.instance.gradient,
            height: 40,
            onTap: () => onSelect(product),
          )
        ],
      ),
    );
  }
}
