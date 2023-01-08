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
        width: lottieWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: EditImageType.values
              .map((e) => GestureDetector(
                    onTap: () => AppRoutes.instance.goGalleryPage(context, e),
                    child: SizedBox(
                      width: itemWidth,
                      height: itemWidth * 3 / 2,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: itemWidth * 2.5 / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                              gradient: const LinearGradient(colors: [Color.fromRGBO(108, 118, 241, 1), Color.fromRGBO(114, 213, 187, 1)]),
                              boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 8), blurRadius: 10)],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(e.icon, width: AppDimensions.instance.iconX(1), color: Colors.white),
                              SizedBox(height: AppDimensions.instance.paddingX(1)),
                              Text(e.title, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white))
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
