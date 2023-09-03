import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/providers/change_background/change_background_provider.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/masked_image.dart';
import 'package:snapeditify/widgets/app_use/widgets_to_image.dart';

class PassportImage extends StatefulWidget {
  const PassportImage({super.key});

  @override
  State<PassportImage> createState() => _PassportImageState();
}

class _PassportImageState extends ProviderStateful<PassportImage, ChangeBackgroundProvider> {
  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Center(
        child: WidgetsToImage(
          controller: provider.widgetsToImageController,
          child: PropConsumer<ChangeBackgroundProvider, double>(
            select: (_) => _.state.ratio,
            builder: (_, child, ___, ratio) {
              return AspectRatio(
                aspectRatio: ratio,
                child: child,
              );
            },
            child: PropConsumer<ChangeBackgroundProvider, Color>(
              select: (_) => _.state.color,
              builder: (_, child, __, color) {
                return Container(
                  color: color,
                  child: child,
                );
              },
              child: Center(
                child: PropConsumer<ChangeBackgroundProvider, double>(
                  select: (_) => _.state.image.ratio,
                  builder: (_, child, __, ratio) {
                    return AspectRatio(
                      aspectRatio: ratio,
                      child: child,
                    );
                  },
                  child: PropConsumer<ChangeBackgroundProvider, Uint8List>(
                    select: (_) => _.state.mask,
                    builder: (_, __, ___, mask) {
                      return MaskedImage(
                        asset: provider.state.image.imageBytes,
                        mask: mask,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
