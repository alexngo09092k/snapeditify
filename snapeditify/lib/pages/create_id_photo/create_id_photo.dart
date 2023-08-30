import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/create_id_photo/widgets/id_photo.dart';
import 'package:snapeditify/pages/create_id_photo/widgets/id_photo_control.dart';
import 'package:snapeditify/providers/edit_background/edit_background_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class CreateIDPhotoPage extends StatefulWidget {
  const CreateIDPhotoPage({super.key});

  @override
  State<CreateIDPhotoPage> createState() => _CreateIDPhotoPageState();
}

class _CreateIDPhotoPageState extends ProviderStateObserver<CreateIDPhotoPage, EditBackgroundProvider> {
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
