import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';

class RemoveObjectImage extends ProviderStateless<IRemoveObjectProvider>  {
  RemoveObjectImage({super.key, this.onStartDraw, this.onEndDraw});
  final Function()? onStartDraw;
  final Function()? onEndDraw;

  _showColorPopup<T>(BuildContext context) {
    return AwesomeAppState.dialog<T>(
      builder: (_) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
                    child: PropConsumer<IRemoveObjectProvider, PainterController>(
                      select: (p) => p.state.paint,
                      builder: (_, __, ___, paint) => FlutterPainter(
                        controller: paint,
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
                  child: PropConsumer<IRemoveObjectProvider, bool>(
                    select: (p) => p.strokeWidthIsChanged,
                    builder: (_, __, ___, strokeWidthIsChanged) => strokeWidthIsChanged
                        ? AwesomeAnimation<double>.tweenSequence(
                            duration: const Duration(milliseconds: 1000),
                            items: [TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 1)],
                            builder: (_, __, animation, ___) => Opacity(
                              opacity: animation.value,
                              child: PropConsumer<IRemoveObjectProvider, double>(
                                select: (p) => p.state.strokeWidth,
                                builder: (_, __, ___, strokeWidth) => Container(
                                  width: strokeWidth,
                                  height: strokeWidth,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.instance.white, width: 2),
                                    borderRadius: BorderRadius.all(Radius.circular(strokeWidth / 2)),
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
                              child: PropConsumer<IRemoveObjectProvider, bool>(
                                select: (p) => p.canUndo,
                                builder: (_, __, ___, canUndo) => CustomIcon.defaultStyle(
                                  context,
                                  icon: AppAssets.instance.icUndo,
                                  color: canUndo ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                            SizedBox(width: AppDimensions.instance.padding),

                            /// REDO BUTTON
                            GestureDetector(
                              onTap: provider.redo,
                              child: PropConsumer<IRemoveObjectProvider, bool>(
                                select: (p) => p.canRedo,
                                builder: (_, __, ___, canRedo) => CustomIcon.defaultStyle(
                                  context,
                                  icon: AppAssets.instance.icRedo,
                                  color: canRedo ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///REMOVE BUTTON
                        PropConsumer<IRemoveObjectProvider, bool>(
                          select: (p) => p.canRemove,
                          builder: (_, __, ___, canRemove) => canRemove
                              ? CustomButton(
                                  onTap: () => provider.removeObjects(context),
                                  title: S.of(context).remove,
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
                              child: PropConsumer<IRemoveObjectProvider, bool>(
                                select: (p) => p.canCompare,
                                builder: (_, __, ___, canCompare) => CustomIcon.defaultStyle(
                                  context,
                                  icon: AppAssets.instance.icCompare,
                                  color: canCompare ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
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
