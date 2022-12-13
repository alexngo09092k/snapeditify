import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/pages/remove_object/widgets/image_editor.dart';
import 'package:snapedit/pages/remove_object/widgets/image_editor_setting.dart';
import 'package:snapedit/pages/remove_object/widgets/revert_button.dart';
import 'package:snapedit/pages/remove_object/widgets/save_button.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/widgets/app_layout.dart';

class RemoveObjectPage extends StatefulWidget {
  const RemoveObjectPage({Key? key}) : super(key: key);

  @override
  State<RemoveObjectPage> createState() => _RemoveObjectPageState();
}

class _RemoveObjectPageState extends ProviderState<RemoveObjectPage, RemoveObjectProvider> {
  void goBack() async {
    if (provider.canSave) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      back: true,
      onBack: goBack,
      center: RevertButton(provider: provider),
      action: SaveButton(provider: provider),
      scroll: false,
      children: [
        ImageEditor(provider: provider),
        ImageEditorSetting(provider: provider),
      ],
    );
  }
}
