import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class AnimeAIStyleList extends StatelessWidget {
  const AnimeAIStyleList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AwesomeAppState.screen.height * 1.2 / 5,
      child: PropConsumer<IAnimeAIProvider, String?>(
        select: (_) => _.category,
        builder: (_, __, p, ___) => PropConsumer<IAnimeAIProvider, List<Effect>>(
          select: (_) => _.styles.where((element) => element.category == p.category).toList(),
          builder: (_, __, ___, styles) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: styles.length,
              itemBuilder: (_, index) => Container(
                padding: EdgeInsets.only(left: AppDimensions.instance.padding),
                child: AnimeStyleItem(
                  key: Key('$index'),
                  style: styles[index],
                  onStyle: (style) => p.restyleImage(context, style.styleId),
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
  const AnimeStyleItem({super.key, required this.style, required this.onStyle});
  final Effect style;
  final Function(Effect) onStyle;

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
                    placeholder: AppAssets.instance.animePlaceholder,
                  ),
                  Positioned(
                    right: 0,
                    child: PropConsumer<IAnimeAIProvider, String?>(
                      select: (_) => _.state.styleId,
                      builder: (_, __, ___, styleId) => styleId == style.styleId
                          ? Padding(
                              padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.1)),
                              child: CustomIcon.defaultStyle(
                                context,
                                icon: CupertinoIcons.check_mark_circled_solid,
                                background: AppColors.instance.white,
                                spacing: AppDimensions.instance.paddingX(0.1),
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
                  child: Text(
                    style.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
