import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';
import 'package:snapedit/pages/edit/widgets/changed_strokewidth.dart';
import 'package:snapedit/widgets/custom_button.dart';
import 'package:snapedit/modules/painter/painter_pure.dart';

class ImagePaint extends StatelessWidget {
  const ImagePaint({Key? key, required this.controller}) : super(key: key);

  final EditController controller;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 1.8 / 3;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.disable,
      height: height,
      child: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (_, __, ___) => controller.state.image != null
                ? Center(
                    child: AspectRatio(
                      aspectRatio: (controller.state.image!.width / controller.state.image!.height),
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
          Center(
            child: ChangedStrokeWidth(controller: controller),
          ),
          Positioned(
              left: 10,
              top: height - 50,
              child: IconButton(
                  onPressed: controller.undo,
                  icon: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (_, __, ___) => Image.asset(
                      controller.canUndo
                          ? AppImages.icUndoNormalNormal3x
                          : AppImages.icUndoDisabledNormal3x,
                      width: 40,
                    ),
                  ))),
          Positioned(
              left: 50,
              top: height - 50,
              child: IconButton(
                  onPressed: controller.redo,
                  icon: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (_, __, ___) => Image.asset(
                      controller.canRedo
                          ? AppImages.icRedoNormalNormal3x
                          : AppImages.icRedoDisabledNormal3x,
                      width: 40,
                    ),
                  ))),
          Positioned(
            left: (width - 110) / 2,
            top: height - 45,
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (_, __, ___) => controller.canRemove
                  ? CustomButton(
                      title: 'Remove',
                      color: AppColors.blue,
                      icon: Image.asset(
                        AppImages.icCheckmarkNormal3x,
                        width: 20,
                      ),
                      width: 110,
                      height: 30,
                      onTap: controller.remove,
                    )
                  : const SizedBox(),
            ),
          ),
          Positioned(
            right: 10,
            top: height - 50,
            child: InkWell(
              onTapDown: (_) => controller.compare(),
              onTapUp:(_) => controller.compare(),
              child: Container(
                width: 40,
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  AppImages.icCompareNormal3x,
                  width: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
