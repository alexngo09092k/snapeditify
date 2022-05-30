import 'package:flutter/material.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';
import 'package:snapedit/widgets/custom_animation.dart';
import 'package:snapedit/common/constants.dart';

class ChangedStrokeWidth extends StatelessWidget {
  const ChangedStrokeWidth({Key? key, required this.controller})
      : super(key: key);

  final EditController controller;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: controller,
        builder: (_, __, ___) => CustomAnimation<double>(
          duration: const Duration(milliseconds: 1000),
          setAnimation: (animationCtr) => TweenSequence<double>([
            TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 1),
            TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: 1),
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
        ),
      );
}
