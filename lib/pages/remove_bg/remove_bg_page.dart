import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/remove_bg/widgets/remove_bg_control.dart';
import 'package:snapeditify/pages/remove_bg/widgets/remove_bg_preview.dart';
import 'package:snapeditify/providers/remove_bg/remove_bg_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class RemoveBGPage extends StatefulWidget {
  const RemoveBGPage({super.key});

  @override
  State<RemoveBGPage> createState() => _RemoveBGPageState();
}

class _RemoveBGPageState extends ProviderStateObserver<RemoveBGPage, IRemoveBGProvider> {
  @override
  void onNextFrame(Duration timestamp) {
    provider.removeBG(context);
    super.onNextFrame(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: "Remove Background",
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<IRemoveBGProvider>(),
      children: const [
        RemoveBGPreview(),
        RemoveBGControl(),
      ],
    );
  }
}
