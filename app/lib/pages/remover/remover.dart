import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/remover/widgets/remove_object_image.dart';
import 'package:snapeditify/pages/remover/widgets/remove_object_control.dart';
import 'package:snapeditify/pages/remover/widgets/remove_object_revert.dart';
import 'package:snapeditify/providers/remover/remover_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class RemoverPage extends StatefulWidget {
  const RemoverPage({super.key});

  @override
  State<RemoverPage> createState() => _RemoverPageState();
}

class _RemoverPageState extends ProviderStateObserver<RemoverPage, IRemoverProvider>{

   @override
  void onNextFrame(Duration timestamp) {
    provider.showBrushGuide();
    super.onNextFrame(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      center: RemoveObjectRevert(),
      action: const SaveButton<IRemoverProvider>(),
      children: [
        RemoveObjectImage(),
       const RemoveObjectControl(),
      ],
    );
  }
}
