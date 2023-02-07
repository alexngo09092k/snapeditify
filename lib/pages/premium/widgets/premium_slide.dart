import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/slideshow/image_slideshow.dart';

class PremiumSlide extends StatelessWidget {
  const PremiumSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: Theme.of(context).primaryColor,
      onPageChanged: (value) {
        Debug.log('Page changed: $value');
      },
      autoPlayInterval: 3000,
      isLoop: true,
      children: [
        Image.asset(
          AppAssets.instance.animeDemo1,
          fit: BoxFit.cover,
        ),
        Image.asset(
          AppAssets.instance.animeDemo2,
          fit: BoxFit.cover,
        ),
        Image.asset(
          AppAssets.instance.animeDemo3,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
