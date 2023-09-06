import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class AnimeEffectList extends StatelessWidget {
  const AnimeEffectList({super.key, required this.category, required this.onEffect});
  final String category;
  final Function(Effect) onEffect;

  @override
  Widget build(BuildContext context) {
    return PropConsumer<IAnimeAIProvider, List<Effect>>(
      select: (_) => _.styles.where((element) => element.category == category).toList(),
      builder: (_, __, p, styles) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: styles.length,
          itemBuilder: (_, index) => Container(
            padding: EdgeInsets.only(left: AppDimensions.instance.padding),
            child: BGEffectItemItem(
              key: Key('$index'),
              effect: styles[index],
              isStart: index == 0,
              isEnd: index + 1 == styles.length,
              onEffect: onEffect,
            ),
          ),
        );
      },
    );
  }
}

class BGEffectItemItem extends StatelessWidget {
  const BGEffectItemItem({
    super.key, 
    required this.effect, 
    required this.onEffect,
    required this.isStart,
    required this.isEnd,
  });
  final Effect effect;
  final bool isStart;
  final bool isEnd;
  final Function(Effect) onEffect;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        double width = constraints.maxHeight - AppDimensions.instance.paddingX(2);
        double height = width;
        return GestureDetector(
          onTap: () => onEffect(effect),
          child: AppCard(
            width: width,
            height: height,
            margin: EdgeInsets.symmetric(
              horizontal: AppDimensions.instance.paddingX(0.25), 
              vertical: AppDimensions.instance.padding,
            ).copyWith(
              left: isStart ? AppDimensions.instance.padding: null,
              right: isEnd? AppDimensions.instance.padding: null,
            ),
            child: PropConsumer<IAnimeAIProvider, String?>(
              select: (_) => _.state.styleId,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                child: CustomImage(
                  image: effect.thumbnailUrl,
                  placeholder: AppAssets.instance.animePlaceholder,
                  width: width, 
                  height: height,
                  fit: BoxFit.fill,
                ),
              ),
              builder: (_, child, ___, styleId) {
                return Container(
                  decoration: BoxDecoration(
                    border:styleId == effect.styleId? Border.fromBorderSide(
                      BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      )
                    ): null,
                    borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                  ),
                  padding: EdgeInsets.all(styleId == effect.styleId ? 2: 0),
                  child: child,
                );
              }
            ),
          ),
        );
      }
    );
  }
}
