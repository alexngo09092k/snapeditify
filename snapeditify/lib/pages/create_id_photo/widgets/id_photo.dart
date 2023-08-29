import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/providers/create_id_photo/create_id_photo_provider.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/masked_image.dart';
import 'package:snapeditify/widgets/app_use/widgets_to_image.dart';

class IDPhoto extends StatefulWidget {
  const IDPhoto({super.key});

  @override
  State<IDPhoto> createState() => _IDPhotoState();
}

class _IDPhotoState extends ProviderStateful<IDPhoto, CreateIDPhotoProvider> {
  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Center(
        child: WidgetsToImage(
          controller: provider.widgetsToImageController,
          child: PropConsumer<CreateIDPhotoProvider, double>(
            select: (_) => _.state.ratio,
            builder: (_, child, ___, ratio) {
              return AspectRatio(
                aspectRatio: ratio,
                child: child,
              );
            },
            child: PropConsumer<CreateIDPhotoProvider, Color>(
              select: (_) => _.state.color,
              builder: (_, child, __, color) {
                return Container(
                  color: color,
                  child: child,
                );
              },
              child: Center(
                child: PropConsumer<CreateIDPhotoProvider, double>(
                  select: (_) => _.state.image.ratio,
                  builder: (_, child, __, ratio) {
                    return AspectRatio(
                      aspectRatio: ratio,
                      child: child,
                    );
                  },
                  child: PropConsumer<CreateIDPhotoProvider, Uint8List>(
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
