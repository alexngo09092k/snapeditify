// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

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
    final lottieWidth = AppDimensions.instance.bannerWidth;
    final heightWidth = lottieWidth * 1.7 / 3;
    return GestureDetector(
      onTap: action,
      child: AppCard(
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.instance.padding,
                        vertical: AppDimensions.instance.paddingX(0.5),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.instance.white.withOpacity(0.3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppDimensions.instance.radiusX(2)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          buttonTitle,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: AppColors.instance.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
