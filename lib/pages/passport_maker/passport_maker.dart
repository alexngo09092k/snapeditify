import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/passport_maker/widgets/passport_image.dart';
import 'package:snapeditify/pages/passport_maker/widgets/passport_maker_control.dart';
import 'package:snapeditify/providers/change_background/change_background_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class PassportMakerPage extends StatefulWidget {
  const PassportMakerPage({super.key});

  @override
  State<PassportMakerPage> createState() => _PassportMakerPageState();
}

class _PassportMakerPageState extends ProviderStateObserver<PassportMakerPage, ChangeBackgroundProvider> {
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
      action: const SaveButton<IChangeBackgroundProvider>(),
      children: const [
        PassportImage(),
        PassportMakerControl(),
      ],
    );
  }
}
