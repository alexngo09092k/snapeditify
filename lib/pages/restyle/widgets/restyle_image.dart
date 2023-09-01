import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

class RestyleImage extends StatelessWidget {
  const RestyleImage({super.key});

  @override
  Widget build(BuildContext context) {
    final IRestyleProvider provider = ManagerProvider.of<IRestyleProvider>();
    return BaseImageEditor(
      builder: (width, height) => Stack(
        children: [
          /// PAINT
          Center(
            child: PropConsumer<IRestyleProvider, PainterController>(
              select: (p) => p.state.paint,
              builder: (_, __, p, paint) => AspectRatio(
                aspectRatio: p.state.image.ratio,
                child: FlutterPainter(controller: paint),
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
              child: PropConsumer<IRestyleProvider, bool>(
                select: (p) => p.canCompare,
                builder: (_, __, ___, canCompare) => CustomIcon.defaultStyle(
                  context,
                  icon: AppAssets.instance.icCompare,
                  color: canCompare ? Theme.of(context).primaryColor : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
