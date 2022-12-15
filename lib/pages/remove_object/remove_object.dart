import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/pages/remove_object/widgets/remove_object_image.dart';
import 'package:snapedit/pages/remove_object/widgets/remove_object_control.dart';
import 'package:snapedit/pages/remove_object/widgets/remove_object_revert.dart';
import 'package:snapedit/pages/remove_object/widgets/remove_object_save.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/widgets/app_layout.dart';

class RemoveObjectPage extends StatefulWidget {
  const RemoveObjectPage({Key? key}) : super(key: key);

  @override
  State<RemoveObjectPage> createState() => _RemoveObjectPageState();
}

class _RemoveObjectPageState extends ProviderState<RemoveObjectPage, RemoveObjectProvider> {
  void goBack() async {
    Navigator.pop(context);
    if (provider.canSave) {
      /// SHOW POPUP
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      onWillPop: () async => false,
      goBack: goBack,
      center: RemoveObjectRevert(provider: provider),
      action: RemoveObjectSave(provider: provider),
      children: [
        RemoveObjectImage(provider: provider),
        RemoveObjectControl(provider: provider),
      ],
    );
  }
}
