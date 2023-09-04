import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/change_bg/change_bg_provider.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

class ChangeBGImage extends StatelessWidget {
  const ChangeBGImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Stack(
        children: [
          /// BG TRANSPARENT
          Center(
            child: PropConsumer<IChangeBGProvider, PainterController>(
              select: (p) => p.state.paint,
              builder: (_, __, p, paint) => AspectRatio(
                aspectRatio: p.state.image.ratio,
                child: Image.asset(AppAssets.instance.bgTransparent, fit: BoxFit.fill),
              ),
            ),
          ),
          /// PAINT
          Center(
            child: PropConsumer<IChangeBGProvider, PainterController>(
              select: (p) => p.state.paint,
              builder: (_, __, p, paint) => AspectRatio(
                aspectRatio: p.state.image.ratio,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    /// IMAGE BACKGROUND
                   PropConsumer<IChangeBGProvider, String?>(
                      select: (_) => _.state.bgImage,
                      builder: (_, __, p, image) {
                        if(image == null) return const SizedBox();
                        if(Configuration.instance.isNetwork(image)) {
                          return CachedNetworkImage(imageUrl: image, fit: BoxFit.fill);
                        }
                        return Image.file(File(image), fit: BoxFit.fill);
                      }
                    ),

                    /// COLOR BACKGROUND
                    PropConsumer<IChangeBGProvider, Color?>(
                      select: (_) => _.state.bgColor,
                      builder: (_, __, p, color) {
                        return Container(
                          decoration: BoxDecoration(
                            color: color,
                          ),
                        );
                      }
                    ),
                    
                    /// IMAGE EDITING
                    FlutterPainter(controller: paint),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
