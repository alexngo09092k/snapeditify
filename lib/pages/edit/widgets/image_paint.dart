import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/providers/edit_provider/edit_provider.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';
import 'package:snapedit/pages/edit/widgets/changed_strokewidth.dart';
import 'package:snapedit/widgets/custom_button.dart';
import 'package:snapedit/widgets/custom_card.dart';

class ImagePaint extends StatelessWidget {
  const ImagePaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 1.7 / 3;
    final double width = MediaQuery.of(context).size.width - AppDimensions.instance.paddingSizeDefault * 2;
    const double iconSize = 40;
    final p = ManagerProvider.of<EditProvider>();
    return SizedBox(
      width: width,
      height: height + 25,
      child: Stack(
        // alignment: Alignment.center,
        children: [
          BorderBackground(
            height: height,
            width: width,
          ),
          MainImagePaint(
            height: height,
            width: width,
          ),
          const Center(
            child: ChangedStrokeWidth(),
          ),
          Positioned(
            left: AppDimensions.instance.paddingSizeExtraSmall,
            top: height - iconSize - AppDimensions.instance.paddingSizeExtraSmall,
            child: IconButton(
              onPressed: p.undo,
              icon: PropConsumer<EditProvider, bool>(
                select: (p) => p.canUndo,
                builder: (_, __, p, ___) => Image.asset(
                  p.canUndo ? AppImages.instance.icUndoNormalNormal3x : AppImages.instance.icUndoDisabledNormal3x,
                  width: iconSize,
                ),
              ),
            ),
          ),
          Positioned(
            left: AppDimensions.instance.paddingSizeExtraSmall + iconSize,
            top: height - iconSize - AppDimensions.instance.paddingSizeExtraSmall,
            child: IconButton(
              onPressed: p.redo,
              icon: PropConsumer<EditProvider, bool>(
                select: (p) => p.canRedo,
                builder: (_, __, p, ___) => Image.asset(
                  p.canRedo ? AppImages.instance.icRedoNormalNormal3x : AppImages.instance.icRedoDisabledNormal3x,
                  width: iconSize,
                ),
              ),
            ),
          ),
          Positioned(
            left: (width - 150) / 2,
            top: height - 25,
            child: PropConsumer<EditProvider, bool>(
              select: (p) => p.canRemove,
              builder: (_, __, p, ___) => p.canRemove
                  ? CustomCard(
                      child: CustomButton(
                        title: S.of(context).remove,
                        gradient: AppColors.instance.gradient,
                        width: 150,
                        height: 50,
                        onTap: () => p.remove(context),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          Positioned(
            right: AppDimensions.instance.paddingSizeExtraSmall,
            top: height - iconSize - AppDimensions.instance.paddingSizeExtraSmall,
            child: InkWell(
              onTapDown: (_) => p.compare(),
              onTapUp: (_) => p.compare(),
              child: Container(
                width: iconSize,
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  AppImages.instance.icCompareNormal3x,
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
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Consumer<EditProvider>(
        builder: (_, __, p) => p.state.image != null
            ? Center(
                child: AspectRatio(
                  aspectRatio: (p.state.image!.width / p.state.image!.height),
                  child: FlutterPainter(
                    controller: p.painterController,
                    onDrawableCreated: (drawable) {
                      Debug.log('onDrawableCreated $drawable');
                    },
                    onDrawableDeleted: (drawable) {
                      Debug.log('onDrawableDeleted $drawable');
                    },
                    onPainterSettingsChanged: (settings) {
                      Debug.log('onPainterSettingsChanged $settings');
                    },
                    onSelectedObjectDrawableChanged: (objectDrawable) {
                      Debug.log('onSelectedObjectDrawableChanged $objectDrawable');
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
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: AppColors.instance.gradient,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.instance.paddingSizeDefault),
          ),
        ),
        padding: const EdgeInsets.all(1),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.instance.lightActive,
            // image: DecorationImage(
            //   image: kIsWeb
            //       ? Image.network(controller.imagePath).image
            //       : Image.file(File(controller.imagePath)).image,
            //   fit: BoxFit.fill,
            //   opacity: 0.3,
            // ),
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimensions.instance.paddingSizeDefault),
            ),
          ),
        ),
      ),
    );
  }
}
