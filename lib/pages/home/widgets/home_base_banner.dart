// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:snapedit/common/constants.dart';
import 'package:snapedit/widgets/custom_button.dart';
import 'package:snapedit/widgets/lottie_viewer.dart';

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
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 8), blurRadius: 10)],
      ),
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
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  CustomButton(
                    onTap: action,
                    title: buttonTitle,
                    titleColor: Colors.white,
                    gradient: const LinearGradient(colors: [Color.fromRGBO(108, 118, 241, 1), Color.fromRGBO(114, 213, 187, 1)]),
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
