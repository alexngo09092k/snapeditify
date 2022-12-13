import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';
import 'package:snapedit/widgets/custom_button.dart';

class ImageEditor extends StatelessWidget {
  const ImageEditor({Key? key, required this.provider}) : super(key: key);
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 1.7 / 3;
    final double width = MediaQuery.of(context).size.width - AppDimensions.instance.padding * 2;
    final double iconSize = AppDimensions.instance.icon;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          /// PAINT
          Center(
            child: AspectRatio(
              aspectRatio: (provider.imageUI.width / provider.imageUI.height),
              child: BasePropConsumer<RemoveObjectProvider, PainterController>(
                listenable: provider,
                select: (p) => p.state.paint,
                builder: (_, __, p, ___) => FlutterPainter(controller: p.state.paint),
              ),
            ),
          ),

          /// STROKE WIDTH
          Center(
            child: BasePropConsumer<RemoveObjectProvider, bool>(
              listenable: provider,
              select: (p) => p.strokeWidthIsChanged,
              builder: (_, __, p, ___) => p.strokeWidthIsChanged
                  ? AwesomeAnimation<double>.tweenSequence(
                      duration: const Duration(milliseconds: 1000),
                      items: [TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 1)],
                      builder: (_, __, animation, ___) => Opacity(
                        opacity: animation.value,
                        child: BasePropConsumer<RemoveObjectProvider, double>(
                          listenable: provider,
                          select: (p) => p.state.strokeWidth,
                          builder: (_, __, ___, ____) => Container(
                            width: p.state.strokeWidth,
                            height: p.state.strokeWidth,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(p.state.strokeWidth / 2)),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),

          /// UNDO BUTTON
          Positioned(
            left: AppDimensions.instance.padding,
            bottom: AppDimensions.instance.padding,
            child: GestureDetector(
              onTap: provider.undo,
              child: BasePropConsumer<RemoveObjectProvider, bool>(
                listenable: provider,
                select: (p) => p.canUndo,
                builder: (_, __, p, ___) => Image.asset(
                  AppAssets.instance.icAdd,
                  color: p.canUndo ? AppColors.instance.blue : AppColors.instance.black,
                  width: iconSize,
                ),
              ),
            ),
          ),

          /// REDO BUTTON
          Positioned(
            left: AppDimensions.instance.padding + iconSize,
            bottom: AppDimensions.instance.padding,
            child: GestureDetector(
              onTap: provider.redo,
              child: PropConsumer<RemoveObjectProvider, bool>(
                select: (p) => p.canRedo,
                builder: (_, __, p, ___) => Image.asset(
                  AppAssets.instance.icAdd,
                  color: p.canRedo ? AppColors.instance.blue : AppColors.instance.black,
                  width: iconSize,
                ),
              ),
            ),
          ),

          ///REMOVE BUTTON
          Positioned(
            left: (width - 150) / 2,
            bottom: AppDimensions.instance.padding,
            child: PropConsumer<RemoveObjectProvider, bool>(
              select: (p) => p.canRemove,
              builder: (_, __, p, ___) => p.canRemove
                  ? CustomButton(
                      onTap: () => provider.removeObjects(context),
                      title: S.of(context).remove,
                      color: AppColors.instance.blue,
                      width: 150,
                      height: 50,
                    )
                  : const SizedBox(),
            ),
          ),

          /// COMPARE BUTTON
          Positioned(
            right: AppDimensions.instance.padding,
            bottom: AppDimensions.instance.padding,
            child: GestureDetector(
              onTapDown: (_) => provider.compare(),
              onTapUp: (_) => provider.compare(),
              child: BasePropConsumer<RemoveObjectProvider, bool>(
                listenable: provider,
                select: (p) => p.canCompare,
                builder: (_, __, p, ___) => Image.asset(
                  AppAssets.instance.icAdd,
                  color: p.canCompare ? AppColors.instance.blue : AppColors.instance.black,
                  width: iconSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
