import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_image.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/save_button.dart';

class EnhancePage extends StatefulWidget {
  const EnhancePage({super.key});

  @override
  State<EnhancePage> createState() => _EnhancePageState();
}

class _EnhancePageState extends ProviderStateObserver<EnhancePage, EnhanceProvider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void onNextFrame(Duration timestamp) {
    provider.enhanceImage(context);
    super.onNextFrame(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: 'Enhance',
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: SaveButton(provider: provider),
      children: [
        EnhanceImage(provider: provider),
      ],
    );
  }
}
