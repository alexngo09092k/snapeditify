import 'package:flutter/material.dart';
import 'package:fluttering/provider/widgets/pstate.dart';
import 'package:snapedit/pages/anime_ai/widgets/anime_ai_image.dart';
import 'package:snapedit/pages/anime_ai/widgets/anime_ai_save.dart';
import 'package:snapedit/pages/anime_ai/widgets/anime_ai_style_list.dart';
import 'package:snapedit/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapedit/widgets/app_layout.dart';

class AnimeAIPage extends StatefulWidget {
  const AnimeAIPage({super.key});

  @override
  State<AnimeAIPage> createState() => _AnimeAIPageState();
}

class _AnimeAIPageState extends ProviderState<AnimeAIPage, AnimeAIProvider> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      back: true,
      screen: 'Anime AI',
      action: AnimeAISave(provider: provider),
      children: [
        AnimeAIImage(provider: provider),
        AnimeAIStyleList(provider: provider),
      ],
    );
  }
}
