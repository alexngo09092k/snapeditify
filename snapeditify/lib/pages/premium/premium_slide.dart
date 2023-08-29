import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/slideshow/image_slideshow.dart';

class PremiumSlide extends StatelessWidget {
  const PremiumSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final height = AwesomeAppState.screen.height * 1 / 3;
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          SizedBox(
            height: height - 5,
            child: ImageSlideshow(
              height: height - 5,
              indicatorColor: Theme.of(context).primaryColor,
              autoPlayInterval: 2000,
              isLoop: true,
              children: const [
                // Image.asset(
                //   AppAssets.instance.animeDemo1,
                //   fit: BoxFit.cover,
                // ),
                // Image.asset(
                //   AppAssets.instance.animeDemo2,
                //   fit: BoxFit.cover,
                // ),
                // Image.asset(
                //   AppAssets.instance.animeDemo3,
                //   fit: BoxFit.cover,
                // ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).colorScheme.background,
                  Theme.of(context).colorScheme.background.withOpacity(0.1),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top,
            left: 0,
            child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.instance.padding),
                child: CustomIcon(
                  CupertinoIcons.back,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
