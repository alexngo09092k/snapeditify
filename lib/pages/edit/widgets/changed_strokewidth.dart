import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapretouch/providers/edit_provider/edit_provider.dart';
import 'package:snapretouch/common/constants.dart';

class ChangedStrokeWidth extends StatelessWidget {
  const ChangedStrokeWidth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PropConsumer<EditProvider, bool>(
        select: (p) => p.state.changedStrokeWidth,
        builder: (_, __, p, ___) => p.state.changedStrokeWidth
            ? AwesomeAnimation<double>.tweenSequence(
                duration: const Duration(milliseconds: 1000),
                items: [TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 1)],
                builder: (_, __, animation, ___) => Opacity(
                  opacity: animation.value,
                  child: PropConsumer<EditProvider, double>(
                    select: (p) => p.strokeWidth,
                    builder: (_, __, ___, ____) => Container(
                      width: p.strokeWidth,
                      height: p.strokeWidth,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.instance.kWhite, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(p.strokeWidth / 2),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      );
}
