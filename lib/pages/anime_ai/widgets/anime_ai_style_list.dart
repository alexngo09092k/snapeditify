import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/services/snap_edit/src/models/response/anime_styles_response.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class AnimeAIStyleList extends StatelessWidget {
  const AnimeAIStyleList({super.key, required this.provider});
  final AnimeAIProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AwesomeAppState.screen.height * 1.2 / 5,
      child: BasePropConsumer<AnimeAIProvider, String?>(
        listenable: provider,
        select: (_) => _.category,
        builder: (_, __, p, ___) => BasePropConsumer<AnimeAIProvider, int>(
          listenable: provider,
          select: (_) => _.styles.where((element) => element.category == p.category).length,
          builder: (_, __, p, ___) {
            final styles = p.styles.where((element) => element.category == p.category).toList();
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: styles.length,
              itemBuilder: (_, index) => Container(
                padding: EdgeInsets.only(left: AppDimensions.instance.padding),
                child: AnimeStyleItem(
                  key: Key('$index'),
                  provider: provider,
                  style: styles[index],
                  onStyle: (style) => provider.restyleImage(context, style.styleId),
                ),
              ),
            );
          },
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
    return GestureDetector(
      onTap: () => onStyle(style),
      child: AppCard(
        width: ((AwesomeAppState.screen.height * 1.2 / 5) * 4.2 / 6),
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.25), vertical: AppDimensions.instance.padding),
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
                              child: CustomIcon(
                                CupertinoIcons.check_mark_circled_solid,
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
    );
  }
}
