import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/make_id_passport/widgets/make_id_passport_control.dart';
import 'package:snapeditify/pages/make_id_passport/widgets/id_passport_image.dart';
import 'package:snapeditify/providers/make_passport_id/make_passport_id_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class MakeIDPassportPage extends StatefulWidget {
  const MakeIDPassportPage({super.key});

  @override
  State<MakeIDPassportPage> createState() => _MakeIDPassportPageState();
}

class _MakeIDPassportPageState extends ProviderStateObserver<MakeIDPassportPage, MakeIDPassportProvider> {
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
      action: const SaveButton<IMakeIDPassportProvider>(),
      children: const [
        PassportIDImage(),
        MakePassportIDControl(),
      ],
    );
  }
}
