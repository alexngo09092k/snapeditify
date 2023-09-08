import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/restore/widgets/restore_tabs.dart';
import 'package:snapeditify/providers/restore/restore_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';
// import 'package:snapeditify/pages/restore/widgets/restore_image.dart';

class RestorePage extends StatefulWidget {
  const RestorePage({super.key});

  @override
  State<RestorePage> createState() => _RestorePageState();
}

class _RestorePageState extends ProviderStateObserver<RestorePage, IRestoreProvider> {

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: S.of(context).restore,
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<IRestoreProvider>(),
      children: const [RestoreTabs()],
    );
  }
}
