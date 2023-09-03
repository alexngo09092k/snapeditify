import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/change_sky/widgets/sky_category_list.dart';
import 'package:snapeditify/pages/change_sky/widgets/sky_image.dart';
import 'package:snapeditify/pages/change_sky/widgets/sky_style_list.dart';
import 'package:snapeditify/providers/change_sky/change_sky_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class ChangeSkyPage extends StatelessWidget {
  const ChangeSkyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final IChangeSkyProvider provider = ManagerProvider.of<ChangeSkyProvider>();
    return AppLayout(
      screen: S.of(context).animeAi,
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<IChangeSkyProvider>(),
      children: const [
        SkyImage(),
        SkyCategoryList(),
        SkyStyleList(),
      ],
    );
  }
}
