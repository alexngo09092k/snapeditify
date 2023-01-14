import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/pages/restyle/widgets/restyle_image.dart';
import 'package:phosart/pages/restyle/widgets/style_list.dart';
import 'package:phosart/providers/restyle/restyle_provider.dart';
import 'package:phosart/widgets/base/app_layout.dart';
import 'package:phosart/widgets/base/save_button.dart';

class RestylePage extends StatefulWidget {
  const RestylePage({super.key});

  @override
  State<RestylePage> createState() => _RestylePageState();
}

class _RestylePageState extends ProviderState<RestylePage, RestyleProvider> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      action: SaveButton(provider: provider),
      children: [
        RestyleImage(provider: provider),
        StyleList(provider: provider),
      ],
    );
  }
}
