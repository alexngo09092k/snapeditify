import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/pages/enhance/widgets/enhance_image.dart';
import 'package:snapedit/pages/enhance/widgets/enhance_result.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';
import 'package:snapedit/widgets/app_layout.dart';

class EnhancePage extends StatefulWidget {
  const EnhancePage({super.key});

  @override
  State<EnhancePage> createState() => _EnhancePageState();
}

class _EnhancePageState extends ProviderState<EnhancePage, EnhanceProvider> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      back: true,
      screen: 'Enhance',
      scroll: false,
      children: [
        EnhanceImage(provider: provider),
        EnhanceResult(provider: provider),
      ],
    );
  }
}
