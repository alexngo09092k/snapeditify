// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:phosart/common/constants.dart';
import 'package:phosart/widgets/base/app_card.dart';
import 'package:phosart/widgets/base/custom_button.dart';
import 'package:phosart/widgets/base/lottie_viewer.dart';

class HomeBaseBanner extends StatelessWidget {
  const HomeBaseBanner({
    Key? key,
    required this.banner,
    required this.title,
    required this.buttonTitle,
    required this.action,
  }) : super(key: key);

  final String banner;
  final String title;
  final String buttonTitle;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lottieWidth = screenWidth - AppDimensions.instance.padding * 2;
    final heightWidth = lottieWidth * 1.7 / 3;
    return AppCard(
      width: lottieWidth,
      height: heightWidth,
      child: Stack(
        children: [
          LottieViewer(
            lottie: banner,
            width: lottieWidth,
            height: heightWidth,
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
                    title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColors.instance.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  CustomButton(
                    onTap: action,
                    title: buttonTitle,
                    gradient: AppColors.instance.gradient,
                    width: 100,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
