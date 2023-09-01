import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

class AnimeAIImage extends StatelessWidget {
  const AnimeAIImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Stack(
        children: [
          /// PAINT
          Center(
            child: PropConsumer<IAnimeAIProvider, PainterController>(
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
            child: PropConsumer<IAnimeAIProvider, bool>(
              select: (p) => p.canCompare,
              builder: (_, __, p, canCompare) => GestureDetector(
                onTapDown: (_) => p.compare(),
                onTapUp: (_) => p.compare(),
                child: CustomIcon.defaultStyle(
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
