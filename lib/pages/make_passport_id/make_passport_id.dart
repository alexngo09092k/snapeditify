import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/make_passport_id/widgets/make_passport_id_control.dart';
import 'package:snapeditify/pages/make_passport_id/widgets/passport_id_image.dart';
import 'package:snapeditify/providers/make_passport_id/make_passport_id_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class MakePassportIDPage extends StatefulWidget {
  const MakePassportIDPage({super.key});

  @override
  State<MakePassportIDPage> createState() => _MakePassportIDPageState();
}

class _MakePassportIDPageState extends ProviderStateObserver<MakePassportIDPage, MakePassportIDProvider> {
  @override
  void onNextFrame(Duration timestamp) {
    provider.makePassportID(context);
    super.onNextFrame(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: S.of(context).createIdPhoto,
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<IMakePassportIDProvider>(),
      children: const [
        PassportIDImage(),
        MakePassportIDControl(),
      ],
    );
  }
}
