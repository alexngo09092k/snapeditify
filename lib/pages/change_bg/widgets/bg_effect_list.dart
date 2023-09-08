import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/change_bg/change_bg_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class BGEffectList extends StatelessWidget {
  const BGEffectList({super.key, required this.category, required this.onEffect});
  final String category;
  final Function(Background) onEffect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PropConsumer<IChangeBGProvider, List<Background>>(
        select: (_) => _.effects.where((element) => element.category == category).toList(),
        builder: (_, __, p, effects) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: effects.length,
            itemBuilder: (_, index) => Container(
              padding: EdgeInsets.only(left: AppDimensions.instance.padding),
              child: BGEffectItemItem(
                key: Key('$index'),
                effect: effects[index],
                onEffect: onEffect,
              ),
            ),
          );
        },
      ),
    );
  }
}

class BGEffectItemItem extends StatelessWidget {
  const BGEffectItemItem({super.key, required this.effect, required this.onEffect});
  final Background effect;
  final Function(Background) onEffect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onEffect(effect),
      child: AppCard(
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.25), vertical: AppDimensions.instance.padding),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                child: CustomImage(
                  image: effect.thumbnailUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
