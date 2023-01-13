import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/anime_ai/anime_ai_provider.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_styles_response.dart';
import 'package:phosart/widgets/base/app_card.dart';
import 'package:phosart/widgets/base/custom_image.dart';

class AnimeAIStyleList extends StatelessWidget {
  const AnimeAIStyleList({super.key, required this.provider});
  final AnimeAIProvider provider;

  _onStyle(AnimeStyle style) {
    provider.videoEffect(style.styleId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
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

class AnimeStyleItem extends StatelessWidget {
  const AnimeStyleItem({super.key, required this.provider, required this.style, required this.onStyle});
  final AnimeAIProvider provider;
  final AnimeStyle style;
  final Function(AnimeStyle) onStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.5), vertical: AppDimensions.instance.padding),
      width: (180 * 3 / 4),
      child: GestureDetector(
        onTap: () => onStyle(style),
        child: AppCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                child: Stack(
                  children: [
                    CustomImage(
                      image: style.thumbnailUrl,
                    ),
                    Positioned(
                      right: 0,
                      child: BasePropConsumer<AnimeAIProvider, String?>(
                        listenable: provider,
                        select: (_) => _.state.styleId,
                        builder: (_, __, p, ___) => p.state.styleId == style.styleId
                            ? Padding(
                                padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.1)),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    style.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
