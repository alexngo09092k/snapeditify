import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/restyle/restyle_provider.dart';
import 'package:phosart/widgets/base/custom_icon.dart';
import 'package:phosart/widgets/base/base_image_editor.dart';
import 'package:phosart/widgets/painter/painter_pure.dart';

class RestyleImage extends StatelessWidget {
  const RestyleImage({Key? key, required this.provider}) : super(key: key);
  final RestyleProvider provider;

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Stack(
        children: [
          /// PAINT
          Center(
            child: AspectRatio(
              aspectRatio: provider.state.image.ratio,
              child: BasePropConsumer<RestyleProvider, PainterController>(
                listenable: provider,
                select: (p) => p.state.paint,
                builder: (_, __, p, ___) => FlutterPainter(controller: p.state.paint),
              ),
            ),
          ),

          /// COMPARE BUTTON
          Positioned(
            right: AppDimensions.instance.padding,
            bottom: AppDimensions.instance.padding,
            child: GestureDetector(
              onTapDown: (_) => provider.compare(context),
              onTapUp: (_) => provider.compare(context),
              child: BasePropConsumer<RestyleProvider, bool>(
                listenable: provider,
                select: (p) => p.canCompare,
                builder: (_, __, p, ___) => CustomIcon.defaultStyle(
                  context,
                  icon: AppAssets.instance.icCompare,
                  color: p.canCompare ? AppColors.instance.mediumSlateBlue : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
