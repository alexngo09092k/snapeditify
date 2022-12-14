import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/providers/remove_object/remove_object_state.dart';
import 'package:snapedit/widgets/base/custom_icon.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';
import 'package:snapedit/widgets/custom_button.dart';

class RemoveObjectImage extends StatelessWidget {
  const RemoveObjectImage({Key? key, required this.provider}) : super(key: key);
  final RemoveObjectProvider provider;

  _showColorPopup(BuildContext context) {
    provider.changeStrokeColor(context, Colors.black.withOpacity(0.5));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 2 / 3;
    final double width = MediaQuery.of(context).size.width;
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
          Positioned(
            bottom: AppDimensions.instance.padding,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
              width: width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      /// UNDO BUTTON
                      GestureDetector(
                        onTap: provider.undo,
                        child: BasePropConsumer<RemoveObjectProvider, bool>(
                          listenable: provider,
                          select: (p) => p.canUndo,
                          builder: (_, __, p, ___) => CustomIcon.defaultStyle(
                            context,
                            icon: AppAssets.instance.icUndo,
                            color: p.canUndo ? AppColors.instance.blue : AppColors.instance.black,
                          ),
                        ),
                      ),
                      SizedBox(width: AppDimensions.instance.padding),

                      /// REDO BUTTON
                      GestureDetector(
                        onTap: provider.redo,
                        child: PropConsumer<RemoveObjectProvider, bool>(
                          select: (p) => p.canRedo,
                          builder: (_, __, p, ___) => CustomIcon.defaultStyle(
                            context,
                            icon: AppAssets.instance.icRedo,
                            color: p.canRedo ? AppColors.instance.blue : AppColors.instance.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///REMOVE BUTTON
                  PropConsumer<RemoveObjectProvider, bool>(
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

                  Row(
                    children: [
                      /// COLOR BUTTON
                      GestureDetector(
                        onTap: () => _showColorPopup(context),
                        child: BasePropConsumer<RemoveObjectProvider, Color>(
                          listenable: provider,
                          select: (p) => p.state.strokeColor,
                          builder: (_, __, p, ___) => Container(
                            width: AppDimensions.instance.icon,
                            height: AppDimensions.instance.icon,
                            decoration: BoxDecoration(
                              color: p.state.strokeColor,
                              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                            ),
                            child: CustomIcon.defaultStyle(
                              context,
                              icon: AppAssets.instance.icAdd,
                              color: p.state.mode == RemoveObjectMode.brush ? AppColors.instance.blue : AppColors.instance.black,
                              size: AppDimensions.instance.icon,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppDimensions.instance.padding),

                      /// COMPARE BUTTON
                      GestureDetector(
                        onTapDown: (_) => provider.compare(),
                        onTapUp: (_) => provider.compare(),
                        child: BasePropConsumer<RemoveObjectProvider, bool>(
                          listenable: provider,
                          select: (p) => p.canCompare,
                          builder: (_, __, p, ___) => Image.asset(
                            AppAssets.instance.icCompare,
                            color: p.canCompare ? AppColors.instance.blue : AppColors.instance.black,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
