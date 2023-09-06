import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class RestyleEffectList extends StatelessWidget {
  const RestyleEffectList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PropConsumer<IRestyleProvider, List<Effect>>(
        select: (_) => _.effects,
        builder: (_, __, p, effects) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: effects.length,
          itemBuilder: (_, index) => StyleItem(
            key: Key('$index'),
            effect: effects[index],
            isStart: index == 0,
            isEnd: index + 1 == effects.length,
            onEffect: (_) => p.restyleImage(context, _.styleId),
          ),
        ),
      ),
    );
  }
}

class StyleItem extends StatelessWidget {
  const StyleItem({
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
    return GestureDetector(
      onTap: () => onEffect(effect),
      child: LayoutBuilder(
        builder: (_, constrains) {
          double height = constrains.maxHeight - AppDimensions.instance.paddingX(2);
          double width = height * 2.6/3;
          return AppCard(
            margin: EdgeInsets.symmetric(
              horizontal: AppDimensions.instance.paddingX(0.5), 
              vertical: AppDimensions.instance.padding,
            ).copyWith(
              left: isStart ? AppDimensions.instance.padding: null,
              right: isEnd? AppDimensions.instance.padding: null,
            ),
            width: width,
            height: height,
            child: PropConsumer<IRestyleProvider, String?>(
              select: (_) => _.state.styleId,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                child: CustomImage(
                  image: effect.thumbnailUrl, 
                  width: width, 
                  height: height,
                  fit: BoxFit.fill,
                  placeholder: AppAssets.instance.animePlaceholder,
                ),
              ),
              builder: (_, child, ___, styleId) {
                return Container(
                  decoration: BoxDecoration(
                    border: styleId == effect.styleId ? Border.fromBorderSide(
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
          );
        }
      ),
    );
  }
}
