import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/restyle/widgets/restyle_image.dart';
import 'package:snapeditify/pages/restyle/widgets/restyle_effect_list.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class RestylePage extends StatelessWidget {
  const RestylePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final provider = ManagerProvider.of<IRestyleProvider>();
    return AppLayout(
      screen: S.of(context).artEffect,
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<IRestyleProvider>(),
      children: const [
        RestyleImage(),
        RestyleEffectList(),
      ],
    );
  }
}
