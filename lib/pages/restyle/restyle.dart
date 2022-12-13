import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/pages/restyle/widgets/image_editor.dart';
import 'package:snapedit/pages/restyle/widgets/image_editor_setting.dart';
import 'package:snapedit/providers/restyle/restyle_provider.dart';
import 'package:snapedit/widgets/app_layout.dart';

class RestylePage extends StatefulWidget {
  const RestylePage({super.key});

  @override
  State<RestylePage> createState() => _RestylePageState();
}

class _RestylePageState extends ProviderState<RestylePage, RestyleProvider> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      back: true,
      scroll: false,
      screen: 'Art effect',
      children: [
        ImageEditor(provider: provider),
        ImageEditorSetting(provider: provider),
      ],
    );
  }
}
