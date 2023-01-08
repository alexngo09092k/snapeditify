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
    final itemWidth = lottieWidth / 4 - AppDimensions.instance.padding;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.padding)),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: EditImageType.values
              .map((e) => GestureDetector(
                    onTap: () => AppRoutes.instance.goGalleryPage(context, e),
                    child: SizedBox(
                      width: itemWidth,
                      height: itemWidth * 3 / 2,
                      child: Center(
                        child: Container(
                          width: itemWidth,
                          height: itemWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                            color: Colors.white,
                            boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 8), blurRadius: 10)],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(e.icon, width: AppDimensions.instance.iconX(1)),
                              SizedBox(height: AppDimensions.instance.paddingX(1)),
                              Text(e.title, style: Theme.of(context).textTheme.bodyText1)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
