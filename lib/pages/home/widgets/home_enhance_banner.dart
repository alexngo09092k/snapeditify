import 'package:flutter/material.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/gallery/gallery_provider.dart';
import 'package:snapedit/widgets/lottie_viewer.dart';

class HomeEnhanceBanner extends StatelessWidget {
  const HomeEnhanceBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lottieWidth = screenWidth - AppDimensions.instance.padding * 2;
    return Stack(
      children: [
        LottieViewer(
          lottie: AppAssets.instance.homeEnhanceBanner,
          width: lottieWidth,
          borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enhance\nimage quality\nwith',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                GestureDetector(
                  onTap: () => AppRoutes.instance.goGalleryPage(context, EditImageType.enhanceImage),
                  child: Container(
                    padding: EdgeInsets.all(AppDimensions.instance.padding),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(AppDimensions.instance.padding),
                    ),
                    child: Text(
                      'Try it now!',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
