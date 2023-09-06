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
              onEffect: onEffect,
            ),
          ),
        );
      },
    );
  }
}

class BGEffectItemItem extends StatelessWidget {
  const BGEffectItemItem({super.key, required this.effect, required this.onEffect});
  final Effect effect;
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
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
              child: Stack(
                children: [
                  CustomImage(
                    image: effect.thumbnailUrl,
                    placeholder: AppAssets.instance.animePlaceholder,
                    width: width, 
                    height: height,
                    fit: BoxFit.fill,
                  ),
                  PropConsumer<IAnimeAIProvider, String?>(
                    select: (_) => _.state.styleId,
                    builder: (_, __, ___, styleId) {
                      if(styleId != effect.styleId) return const SizedBox();
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.4), 
                        ),
                        child: Center(
                          child: Icon(
                            Icons.tune_outlined, 
                            color: AppColors.instance.white,
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
