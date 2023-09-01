import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/sky/sky_category_list.dart';
import 'package:snapeditify/pages/sky/sky_image.dart';
import 'package:snapeditify/pages/sky/sky_style_list.dart';
import 'package:snapeditify/providers/sky/sky_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class SkyPage extends StatelessWidget {
  const SkyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ISkyProvider provider = ManagerProvider.of<SkyProvider>();
    return AppLayout(
      screen: S.of(context).animeAi,
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<ISkyProvider>(),
      children: const [
        SkyImage(),
        SkyCategoryList(),
        SkyStyleList(),
      ],
    );
  }
}
