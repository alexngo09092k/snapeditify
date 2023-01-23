import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/remove_object/remove_object_provider.dart';
import 'package:phosart/widgets/base/custom_icon.dart';
import 'package:phosart/widgets/base/base_image_editor.dart';
import 'package:phosart/widgets/painter/painter_pure.dart';
import 'package:phosart/widgets/base/custom_button.dart';

class RemoveObjectImage extends StatelessWidget {
  const RemoveObjectImage({Key? key, required this.provider, this.onStartDraw, this.onEndDraw}) : super(key: key);
  final RemoveObjectProvider provider;
  final Function()? onStartDraw;
  final Function()? onEndDraw;

  _showColorPopup<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            child: ColorPicker(
              pickerColor: provider.state.strokeColor,
              paletteType: PaletteType.hueWheel,
              onColorChanged: (Color color) => provider.changeStrokeColor(context, color),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
        builder: (width, height) => Stack(
              children: [
                /// PAINT
                Center(
                  child: AspectRatio(
                    aspectRatio: provider.state.image.ratio,
                    child: BasePropConsumer<RemoveObjectProvider, PainterController>(
                      listenable: provider,
                      select: (p) => p.state.paint,
                      builder: (_, __, p, ___) => FlutterPainter(
                        controller: p.state.paint,
                        onHorizontalDragDown: (_) {
                          if (onStartDraw != null) onStartDraw!();
                        },
                        onHorizontalDragUp: () {
                          if (onEndDraw != null) onEndDraw!();
                        },
                      ),
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
                                  color: p.canUndo ? Theme.of(context).primaryColor : null,
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
                                  color: p.canRedo ? Theme.of(context).primaryColor : null,
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
                                  title: 'Remove',
                                  gradient: AppColors.instance.gradient,
                                  width: 100,
                                )
                              : const SizedBox(),
                        ),

                        Row(
                          children: [
                            /// COLOR BUTTON
                            GestureDetector(
                              onTap: () => _showColorPopup(context),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomIcon.defaultStyle(
                                    context,
                                    icon: AppAssets.instance.icColor,
                                    normal: true,
                                  ),
                                ],
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
                                builder: (_, __, p, ___) => CustomIcon.defaultStyle(
                                  context,
                                  icon: AppAssets.instance.icCompare,
                                  color: p.canCompare ? Theme.of(context).primaryColor : null,
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
            ));
  }
}
