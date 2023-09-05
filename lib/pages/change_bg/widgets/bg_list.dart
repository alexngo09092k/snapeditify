import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/change_bg/change_bg_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class BGList extends StatelessWidget {
  const BGList({super.key, required this.category, required this.onBG});
  final String category;
  final Function(Background) onBG;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PropConsumer<IChangeBGProvider, List<Background>>(
        select: (_) => _.backgrounds.where((element) => element.category == category).toList(),
        builder: (_, __, p, backgrounds) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: backgrounds.length,
            itemBuilder: (_, index) => Container(
              padding: EdgeInsets.only(left: AppDimensions.instance.padding),
              child: BGItemItem(
                key: Key('$index'),
                background: backgrounds[index],
                onBG: onBG,
              ),
            ),
          );
        },
      ),
    );
  }
}

class BGItemItem extends StatelessWidget {
  const BGItemItem({super.key, required this.background, required this.onBG});
  final Background background;
  final Function(Background) onBG;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onBG(background),
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
                  image: background.thumbnailUrl,
                  placeholder: AppAssets.instance.animePlaceholder,
                  fit: BoxFit.fill,
                ),
              ),
              // Positioned(
              //   right: 0,
              //   child: PropConsumer<IChangeBGProvider, String?>(
              //     select: (_) => _.state.bgImage,
              //     builder: (_, __, ___, bgImage) => bgImage == background.thumbnailUrl
              //         ? Padding(
              //             padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.1)),
              //             child: CustomIcon.defaultStyle(
              //               context,
              //               icon: CupertinoIcons.check_mark_circled_solid,
              //               background: AppColors.instance.white,
              //               spacing: AppDimensions.instance.paddingX(0.1),
              //               color: Theme.of(context).colorScheme.primary,
              //             ),
              //           )
              //         : const SizedBox(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
