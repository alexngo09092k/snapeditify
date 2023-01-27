import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/remove_object/widgets/remove_object_image.dart';
import 'package:snapeditify/pages/remove_object/widgets/remove_object_control.dart';
import 'package:snapeditify/pages/remove_object/widgets/remove_object_revert.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/save_button.dart';

class RemoveObjectPage extends StatefulWidget {
  const RemoveObjectPage({Key? key}) : super(key: key);

  @override
  State<RemoveObjectPage> createState() => _RemoveObjectPageState();
}

class _RemoveObjectPageState extends ProviderStateObserver<RemoveObjectPage, RemoveObjectProvider> {
  @override
  void onNextFrame(Duration timestamp) {
    provider.showBrushGuide(context);
    super.onNextFrame(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      center: RemoveObjectRevert(provider: provider),
      action: SaveButton(provider: provider),
      children: [
        RemoveObjectImage(provider: provider),
        RemoveObjectControl(provider: provider),
      ],
    );
  }
}
