import 'package:flutter/material.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class HomeOptions extends StatelessWidget {
  const HomeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final contentMaxWidth = AppDimensions.instance.contentMaxWidth;
    final itemWidth = contentMaxWidth / 4 - AppDimensions.instance.gridDelegate.mainAxisSpacing * 2;
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.instance.paddingX(0.5)),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: AppDimensions.instance.gridDelegate.mainAxisSpacing,
        runSpacing: AppDimensions.instance.gridDelegate.crossAxisSpacing,
        children: EditImageType.values
            .map((e) => GestureDetector(
                  onTap: () => AppRoutes.instance.goAlbumsPage(context, e),
                  child: AppCard(
                    margin: EdgeInsets.all(AppDimensions.instance.paddingX(0.25)),
                    width: itemWidth,
                    height: itemWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomIcon(e.icon, size: AppDimensions.instance.icon),
                        SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                        Text(e.title, style: Theme.of(context).textTheme.bodyLarge)
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
