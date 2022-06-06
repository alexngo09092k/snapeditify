import 'package:flutter/material.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';
import 'package:snapretouch/widgets/custom_animation.dart';
import 'package:snapretouch/common/constants.dart';

class ChangedStrokeWidth extends StatelessWidget {
  const ChangedStrokeWidth({Key? key, required this.controller})
      : super(key: key);

  final EditController controller;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: controller,
        builder: (_, __, ___) => controller.state.changedStrokeWidth ? CustomAnimation<double>(
          duration: const Duration(milliseconds: 1000),
          setAnimation: (animationCtr) => TweenSequence<double>([
            TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 1),
          ]).animate(animationCtr),
          builder: (_, __, animation, ___) => Opacity(
            opacity: animation.value,
            child: Container(
              width: controller.strokeWidth,
              height: controller.strokeWidth,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kWhite, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(controller.strokeWidth / 2),
                ),
              ),
            ),
          ),
        ): const SizedBox(),
      );
}
