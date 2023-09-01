import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class StyleList extends StatelessWidget {
  const StyleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AwesomeAppState.screen.height * 1.2 / 5,
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.5), vertical: AppDimensions.instance.padding),
      child: PropConsumer<IRestyleProvider, List<Effect>>(
        select: (_) => _.styles,
        builder: (_, __, p, styles) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: styles.length,
          itemBuilder: (_, index) => StyleItem(
            key: Key('$index'),
            style: styles[index],
            onSelect: (_) => p.restyleImage(context, _.styleId),
          ),
        ),
      ),
    );
  }
}

class StyleItem extends StatelessWidget {
  const StyleItem({super.key, required this.style, required this.onSelect});
  final Effect style;
  final Function(Effect) onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(style),
      child: AppCard(
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.5), vertical: AppDimensions.instance.padding),
        width: (AwesomeAppState.screen.height * 1.2 / 5) * 3 / 6.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
              child: Stack(
                children: [
                  CustomImage(image: style.thumbnailUrl),
                  Positioned(
                    right: 0,
                    child: PropConsumer<IRestyleProvider, String?>(
                      select: (_) => _.state.styleId,
                      builder: (_, __, ___, styleId) => styleId == style.styleId
                          ? Padding(
                              padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.1)),
                              child: CustomIcon.defaultStyle(
                                context,
                                icon: CupertinoIcons.check_mark_circled_solid,
                                spacing: AppDimensions.instance.paddingX(0.1),
                                background: AppColors.instance.white,
                                color: Theme.of(context).colorScheme.primary,
                                size: AppDimensions.instance.iconX(0.8),
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
