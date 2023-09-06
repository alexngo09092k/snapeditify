import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/change_sky/widgets/remove_sky_preview.dart';
import 'package:snapeditify/providers/change_sky/change_sky_provider.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

class SkyImage extends StatelessWidget {
  const SkyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Stack(
        children: [
          /// SKY
          Center(
            child: PropConsumer<IChangeSkyProvider, PainterController>(
              select: (p) => p.state.paint,
              builder: (_, __, p, paint) => AspectRatio(
                aspectRatio: p.state.image.ratio,
                child: FlutterPainter(controller: paint),
              ),
            ),
          ),
          
          /// REMOVED SKY
          const RemoveSkyPreview(),
        ],
      ),
    );
  }
}
