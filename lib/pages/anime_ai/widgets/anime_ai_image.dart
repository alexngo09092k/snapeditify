import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapedit/widgets/base/custom_icon.dart';
import 'package:snapedit/widgets/base_image_editor.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';

class AnimeAIImage extends StatelessWidget {
  const AnimeAIImage({super.key, required this.provider});
  final AnimeAIProvider provider;

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Stack(
        children: [
          /// PAINT
          Center(
            child: AspectRatio(
              aspectRatio: (provider.imageUI.width / provider.imageUI.height),
              child: BasePropConsumer<AnimeAIProvider, PainterController>(
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
              onTapDown: (_) => provider.compare(),
              onTapUp: (_) => provider.compare(),
              child: BasePropConsumer<AnimeAIProvider, bool>(
                listenable: provider,
                select: (p) => p.canCompare,
                builder: (_, __, p, ___) => CustomIcon.defaultStyle(
                  context,
                  icon: AppAssets.instance.icCompare,
                  color: p.canCompare ? AppColors.instance.blue : AppColors.instance.blue100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
