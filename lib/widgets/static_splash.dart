import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/widgets/app_logo.dart';
import 'package:snapretouch/widgets/custom_animation.dart';
import 'package:flutter/material.dart';

class StaticSplash extends StatelessWidget {
  StaticSplash(
      {Key? key,
      this.name = '',
      this.message = '',
      this.image = '',
      this.backgroundcolor,
      this.onEnd,
      this.after,
      this.duration = const Duration(milliseconds: 2000)})
      : super(key: key);
  final Color? backgroundcolor;
  final Duration duration;
  Function? onEnd;
  String image;
  String name;
  String message;
  Duration? after;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAnimation<double>(
            duration: duration,
            after: duration,
            onEnd: onEnd,
            setAnimation: (controller) => TweenSequence<double>([
              TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 2),
              // TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 1),
            ]).animate(controller),
            builder: (_, __, animation, ___) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: animation.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppLogo(
                          width: MediaQuery.of(context).size.width * 0.8 / 2,
                          image: image,
                        ),
                        const SizedBox(height: AppDimensions.paddingSizeDefault),
                        Text(
                          message,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
