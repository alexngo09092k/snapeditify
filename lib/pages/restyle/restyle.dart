import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/restyle/widgets/restyle_image.dart';
import 'package:snapeditify/pages/restyle/widgets/style_list.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class RestylePage extends StatefulWidget {
  const RestylePage({super.key});

  @override
  State<RestylePage> createState() => _RestylePageState();
}

class _RestylePageState extends ProviderState<RestylePage, RestyleProvider> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: S.of(context).artEffect,
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: SaveButton(provider: provider),
      children: [
        RestyleImage(provider: provider),
        StyleList(provider: provider),
      ],
    );
  }
}
