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
      height: AwesomeAppState.screen.height * 0.2,
      child: PropConsumer<IRestyleProvider, List<Effect>>(
        select: (_) => _.effects,
        builder: (_, __, p, effects) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: effects.length,
          itemBuilder: (_, index) => StyleItem(
            key: Key('$index'),
            effect: effects[index],
            onEffect: (_) => p.restyleImage(context, _.styleId),
          ),
        ),
      ),
    );
  }
}

class StyleItem extends StatelessWidget {
  const StyleItem({super.key, required this.effect, required this.onEffect});
  final Effect effect;
  final Function(Effect) onEffect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onEffect(effect),
      child: LayoutBuilder(
        builder: (_, constrains) {
          double height = constrains.maxHeight - AppDimensions.instance.paddingX(2);
          double width = height * 2/3;
          return AppCard(
            margin: EdgeInsets.symmetric(
              horizontal: AppDimensions.instance.paddingX(0.5), 
              vertical: AppDimensions.instance.padding,
            ),
            width: width,
            height: height,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
              child: Stack(
                children: [
                  CustomImage(
                    image: effect.thumbnailUrl, 
                    width: width, 
                    height: height,
                    fit: BoxFit.fill,
                  ),
                  PropConsumer<IRestyleProvider, String?>(
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
          );
        }
      ),
    );
  }
}
