import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/anime_ai/widgets/anime_effect_category_list.dart';
import 'package:snapeditify/pages/anime_ai/widgets/anime_ai_image.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/save_button.dart';

class AnimeAIPage extends StatelessWidget {
  const AnimeAIPage({super.key});

  @override
  Widget build(BuildContext context) {
    final IAnimeAIProvider provider = ManagerProvider.of<IAnimeAIProvider>();
    return AppLayout(
      screen: S.of(context).animeAi,
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: const SaveButton<IAnimeAIProvider>(),
      children: const [
        AnimeAIImage(),
        AnimeEffectCategoryList(),
      ],
    );
  }
}
