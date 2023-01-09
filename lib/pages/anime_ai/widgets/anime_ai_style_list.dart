import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/pages/anime_ai/widgets/anime_style_item.dart';
import 'package:phosart/providers/anime_ai/anime_ai_provider.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_styles_response.dart';

class AnimeAIStyleList extends StatelessWidget {
  const AnimeAIStyleList({super.key, required this.provider});
  final AnimeAIProvider provider;

  _onStyle(AnimeStyle style) {
    provider.videoEffect(style.styleId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AwesomeAppState.screen.height * 1 / 5,
      child: BasePropConsumer<AnimeAIProvider, int>(
        listenable: provider,
        select: (_) => _.styles.length,
        builder: (_, __, p, ___) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: p.styles.length,
          itemBuilder: (_, index) => Container(
            padding: EdgeInsets.only(left: AppDimensions.instance.padding),
            child: AnimeStyleItem(
              key: Key('$index'),
              provider: provider,
              style: p.styles[index],
              onStyle: _onStyle,
            ),
          ),
        ),
      ),
    );
  }
}
