import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/remove_object/widgets/remove_object_image.dart';
import 'package:snapeditify/pages/remove_object/widgets/remove_object_control.dart';
import 'package:snapeditify/pages/remove_object/widgets/remove_object_revert.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class RemoveObjectPage extends StatefulWidget {
  const RemoveObjectPage({super.key});

  @override
  State<RemoveObjectPage> createState() => _RemoveObjectPageState();
}

class _RemoveObjectPageState extends ProviderStateObserver<RemoveObjectPage, IRemoveObjectProvider>{

   @override
  void onNextFrame(Duration timestamp) {
    if (ManagerProvider.of<GalleryProvider>().imageTool == ImageTool.oneTouchRemoveAll) {
      provider.toAIOneTouchSuggest(context);
    }else {
      provider.showBrushGuide();
    }
    super.onNextFrame(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      center: RemoveObjectRevert(),
      action: const SaveButton<IRemoveObjectProvider>(),
      children: [
        RemoveObjectImage(),
       const RemoveObjectControl(),
      ],
    );
  }
}
