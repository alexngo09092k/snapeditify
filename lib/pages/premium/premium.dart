import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'premium_description.dart';
import 'premium_product_list.dart';
import 'premium_slide.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const PremiumSlide(),
            SizedBox(height: AppDimensions.instance.padding),
            const PremiumDescription(),
            SizedBox(height: AppDimensions.instance.padding),
            const PremiumProductList(),
          ],
        ),
      ),
    );
  }
}