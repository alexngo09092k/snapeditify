import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
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
        // Image.asset(
        //   'images/sample_image_1.jpg',
        //   fit: BoxFit.cover,
        // ),
        // Image.asset(
        //   'images/sample_image_2.jpg',
        //   fit: BoxFit.cover,
        // ),
        // Image.asset(
        //   'images/sample_image_3.jpg',
        //   fit: BoxFit.cover,
        // ),
      ],
    );
  }
}
