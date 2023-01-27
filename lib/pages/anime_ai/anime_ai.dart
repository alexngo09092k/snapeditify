import 'package:flutter/material.dart';
import 'package:fluttering/provider/widgets/pstate.dart';
import 'package:snapeditify/pages/anime_ai/widgets/anime_ai_category_list.dart';
import 'package:snapeditify/pages/anime_ai/widgets/anime_ai_image.dart';
import 'package:snapeditify/pages/anime_ai/widgets/anime_ai_style_list.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/save_button.dart';

class AnimeAIPage extends StatefulWidget {
  const AnimeAIPage({super.key});

  @override
  State<AnimeAIPage> createState() => _AnimeAIPageState();
}

class _AnimeAIPageState extends ProviderState<AnimeAIPage, AnimeAIProvider> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: 'Anime AI',
      onWillPop: () => provider.goBack(context, true),
      goBack: () => provider.goBack(context),
      action: SaveButton(provider: provider),
      children: [
        AnimeAIImage(provider: provider),
        AnimeAICategoryList(provider: provider),
        AnimeAIStyleList(provider: provider),
      ],
    );
  }
}
