import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/change_sky/change_sky_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class SkyEffectList extends StatelessWidget {
  const SkyEffectList({super.key, required this.category, required this.onEffect});
  final String category;
  final Function(Background) onEffect;

  @override
  Widget build(BuildContext context) {
    return PropConsumer<IChangeSkyProvider, List<Background>>(
      select: (_) => _.effects.where((element) => element.category == category).toList(),
      builder: (_, __, p, effects) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: effects.length,
          itemBuilder: (_, index) => Container(
            padding: EdgeInsets.only(left: AppDimensions.instance.padding),
            child: SkyEffectItemItem(
              key: Key('$index'),
              effect: effects[index],
              isStart: index == 0,
              isEnd: index + 1 == effects.length,
              onEffect: onEffect,
            ),
          ),
        );
      },
    );
  }
}

class SkyEffectItemItem extends StatelessWidget {
  const SkyEffectItemItem({
    super.key, 
    required this.effect, 
    required this.onEffect,
    required this.isStart,
    required this.isEnd,
  });
  final Background effect;
  final bool isStart;
  final bool isEnd;
  final Function(Background) onEffect;

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
            child: PropConsumer<IChangeSkyProvider,Background?>(
              select: (_) => _.state.sky,
              child:ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                child: CustomImage(
                  image: effect.thumbnailUrl,
                  placeholder: AppAssets.instance.animePlaceholder,
                  width: width, 
                  height: height,
                  fit: BoxFit.fill,
                ),
              ),
              builder: (_, child, ___, sky) {
                return Container(
                  decoration: BoxDecoration(
                    border:sky?.url == effect.url? Border.fromBorderSide(
                      BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      )
                    ): null,
                    borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                  ),
                  padding: EdgeInsets.all(sky?.url == effect.url ? 2: 0),
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
