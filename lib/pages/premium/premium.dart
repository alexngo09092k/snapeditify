import 'package:flutter/material.dart';
import 'package:snapeditify/pages/premium/widgets/premium_description.dart';
import 'package:snapeditify/pages/premium/widgets/premium_product_list.dart';
import 'package:snapeditify/pages/premium/widgets/premium_slide.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      children: [
        PremiumSlide(),
        PremiumDescription(),
        PremiumProductList(),
      ],
    );
  }
}
