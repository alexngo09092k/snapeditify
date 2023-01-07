import 'package:flutter/material.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/gallery/gallery_provider.dart';

class HomeOptions extends StatelessWidget {
  const HomeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lottieWidth = screenWidth - AppDimensions.instance.padding * 2;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.padding)),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        width: lottieWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// DELETE
            _Option(
              title: 'Remover',
              icon: AppAssets.instance.icRemoveObject,
              onTap: (_) => AppRoutes.instance.goGalleryPage(context, EditImageType.removeObject),
            ),
            _Option(
              title: 'Enhance',
              icon: AppAssets.instance.icEnhence,
              onTap: (_) => AppRoutes.instance.goGalleryPage(context, EditImageType.enhanceImage),
            ),
            _Option(
              title: 'Art Effect',
              icon: AppAssets.instance.icArtEffect,
              onTap: (_) => AppRoutes.instance.goGalleryPage(context, EditImageType.applyArtEffect),
            ),
            _Option(
              title: 'Anime AI',
              icon: AppAssets.instance.icArtEffect,
              onTap: (_) => AppRoutes.instance.goGalleryPage(context, EditImageType.animeAI),
            ),
          ],
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({Key? key, required this.icon, required this.title, required this.onTap}) : super(key: key);

  final String title;
  final String icon;
  final Function(BuildContext) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(icon, width: AppDimensions.instance.iconX(1)),
          SizedBox(height: AppDimensions.instance.paddingX(1)),
          Text(title, style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }
}
