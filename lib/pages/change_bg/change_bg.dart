import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/change_bg/widgets/change_bg_control.dart';
import 'package:snapeditify/pages/change_bg/widgets/change_bg_image.dart';
import 'package:snapeditify/providers/change_bg/change_bg_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class ChangeBGPage extends StatefulWidget {
  const ChangeBGPage({super.key});

  @override
  State<ChangeBGPage> createState() => _ChangeBGPageState();
}

class _ChangeBGPageState extends ProviderStateObserver<ChangeBGPage, IChangeBGProvider> {

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: "Change Background",
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<IChangeBGProvider>(),
      children: const [
        ChangeBGImage(),
        ChangeBGControl(),
      ],
    );
  }
}
