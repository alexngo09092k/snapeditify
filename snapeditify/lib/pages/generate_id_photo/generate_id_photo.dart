import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/generate_id_photo/widgets/id_photo.dart';
import 'package:snapeditify/pages/generate_id_photo/widgets/id_photo_control.dart';
import 'package:snapeditify/providers/edit_background/edit_background_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class GenerateIDPhotoPage extends StatefulWidget {
  const GenerateIDPhotoPage({super.key});

  @override
  State<GenerateIDPhotoPage> createState() => _GenerateIDPhotoPageState();
}

class _GenerateIDPhotoPageState extends ProviderStateObserver<GenerateIDPhotoPage, EditBackgroundProvider> {
  @override
  void onNextFrame(Duration timestamp) {
    provider.removeBackground(context);
    super.onNextFrame(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: S.of(context).createIdPhoto,
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<IEditBackgroundProvider>(),
      children: const [
        IDPhoto(),
        AIPhotoSizeControl(),
      ],
    );
  }
}
