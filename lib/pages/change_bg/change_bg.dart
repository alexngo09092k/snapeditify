import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/change_bg/widgets/bg_effect_category_list.dart';
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
      screen: S.of(context).editBackground,
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<IChangeBGProvider>(),
      children: const [
        ChangeBGImage(),
        BGEffectCategoryList(),
      ],
    );
  }
}
