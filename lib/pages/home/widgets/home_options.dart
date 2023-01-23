import 'package:flutter/material.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';
import 'package:phosart/widgets/base/app_card.dart';
import 'package:phosart/widgets/base/custom_icon.dart';

class HomeOptions extends StatelessWidget {
  const HomeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lottieWidth = screenWidth - AppDimensions.instance.padding * 2;
    final itemWidth = lottieWidth / 4 - AppDimensions.instance.padding;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.padding)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: EditImageType.values
            .map((e) => GestureDetector(
                  onTap: () => AppRoutes.instance.goGalleryPage(context, e),
                  child: AppCard(
                    margin: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.25), vertical: AppDimensions.instance.padding),
                    width: itemWidth,
                    height: itemWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomIcon(e.icon, size: AppDimensions.instance.iconX(1)),
                        SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                        Text(e.title, style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
