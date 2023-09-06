import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/change_sky/widgets/remove_sky_preview.dart';
import 'package:snapeditify/providers/change_sky/change_sky_provider.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';
import 'package:snapeditify/widgets/app_use/widgets_to_image.dart';

class SkyImage extends StatefulWidget {
  const SkyImage({super.key});

  @override
  State<SkyImage> createState() => _SkyImageState();
}

class _SkyImageState extends ProviderStateObserver<SkyImage, IChangeSkyProvider> {
  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => PropConsumer<IChangeSkyProvider, PainterController>(
        select: (p) => p.state.paint,
        builder: (_, __, p, paint) => WidgetsToImage(
          controller: provider.captureController,
          child: AspectRatio(
            aspectRatio: p.state.image.ratio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// SKY
                FlutterPainter(controller: paint),
        
                /// REMOVED SKY
                const RemoveSkyPreview(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
