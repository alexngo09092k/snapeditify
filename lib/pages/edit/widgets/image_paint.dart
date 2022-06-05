import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/modules/painter/painter_pure.dart';
import 'package:snapretouch/pages/edit/widgets/changed_strokewidth.dart';
import 'package:snapretouch/widgets/custom_button.dart';

class ImagePaint extends StatelessWidget {
  const ImagePaint({Key? key, required this.controller}) : super(key: key);

  final EditController controller;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 1.7 / 3;
    final double width = MediaQuery.of(context).size.width - AppDimensions.paddingSizeDefault * 2;
    const double iconSize = 40;
    return SizedBox(
      width: width,
      height: height + 25,
      child: Stack(
        alignment: Alignment.center,
        children: [
          BorderBackground(
            height: height,
            width: width,
            controller: controller,
          ),
          MainImagePaint(
            height: height - iconSize,
            width: width - AppDimensions.paddingSizeDefault,
            controller: controller,
          ),
          Center(
            child: ChangedStrokeWidth(controller: controller),
          ),
          Positioned(
              left: AppDimensions.paddingSizeExtraSmall,
              top: height - iconSize,
              child: IconButton(
                  onPressed: controller.undo,
                  icon: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (_, __, ___) => Image.asset(
                      controller.canUndo
                          ? AppImages.icUndoNormalNormal3x
                          : AppImages.icUndoDisabledNormal3x,
                      width: iconSize,
                    ),
                  ))),
          Positioned(
              left: AppDimensions.paddingSizeExtraSmall + iconSize,
              top: height - iconSize,
              child: IconButton(
                  onPressed: controller.redo,
                  icon: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (_, __, ___) => Image.asset(
                      controller.canRedo
                          ? AppImages.icRedoNormalNormal3x
                          : AppImages.icRedoDisabledNormal3x,
                      width: iconSize,
                    ),
                  ))),
          Positioned(
            left: (width - 150) / 2,
            top: height - 25,
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (_, __, ___) => controller.canRemove
                  ? CustomButton(
                      title: S.of(context).remove,
                      gradient: AppColors.gradient,
                      width: 150,
                      height: 50,
                      onTap: controller.remove,
                    )
                  : const SizedBox(),
            ),
          ),
          Positioned(
            right: AppDimensions.paddingSizeExtraSmall,
            top: height - iconSize,
            child: InkWell(
              onTapDown: (_) => controller.compare(),
              onTapUp: (_) => controller.compare(),
              child: Container(
                width: iconSize,
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  AppImages.icCompareNormal3x,
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

class MainImagePaint extends StatelessWidget {
  const MainImagePaint({
    Key? key,
    required this.height,
    required this.width,
    required this.controller,
  }) : super(key: key);

  final double height;
  final double width;
  final EditController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (_, __, ___) => controller.state.image != null
            ? Center(
                child: AspectRatio(
                  aspectRatio: (controller.state.image!.width /
                      controller.state.image!.height),
                  child: FlutterPainter(
                    controller: controller.painterController,
                    onDrawableCreated: (drawable) {
                      printLog('onDrawableCreated $drawable');
                    },
                    onDrawableDeleted: (drawable) {
                      printLog('onDrawableDeleted $drawable');
                    },
                    onPainterSettingsChanged: (settings) {
                      printLog('onPainterSettingsChanged $settings');
                    },
                    onSelectedObjectDrawableChanged: (objectDrawable) {
                      printLog(
                          'onSelectedObjectDrawableChanged $objectDrawable');
                    },
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

class BorderBackground extends StatelessWidget {
  const BorderBackground({
    Key? key,
    required this.height,
    required this.width,
    required this.controller,
  }) : super(key: key);

  final double height;
  final double width;
  final EditController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: AppColors.gradient,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.paddingSizeDefault),
          ),
        ),
        padding: const EdgeInsets.all(1),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.kTeal50,
            image: DecorationImage(
              image: Image.asset(controller.imagePath).image,
              fit: BoxFit.fill,
              opacity: 0.3,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppDimensions.paddingSizeDefault),
            ),
          ),
        ),
      ),
    );
  }
}
