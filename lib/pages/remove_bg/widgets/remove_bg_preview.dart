import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/remove_bg/remove_bg_provider.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/masked_image.dart';
import 'package:snapeditify/widgets/app_use/widgets_to_image.dart';

class RemoveBGPreview extends StatefulWidget {
  const RemoveBGPreview({super.key});

  @override
  State<RemoveBGPreview> createState() => _RemoveBGPreviewState();
}

class _RemoveBGPreviewState extends ProviderStateObserver<RemoveBGPreview, IRemoveBGProvider> {
  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Center(
        child: WidgetsToImage(
          controller: provider.captureController,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: Image.asset(AppAssets.instance.noImage).image, 
                fit: BoxFit.fill,
              )
            ),
            child: Center(
              child: PropConsumer<RemoveBGProvider, double>(
                select: (_) => _.state.image.ratio,
                builder: (_, child, __, ratio) {
                  return AspectRatio(
                    aspectRatio: ratio,
                    child: child,
                  );
                },
                child: PropConsumer<RemoveBGProvider, Uint8List>(
                  select: (_) => _.state.mask,
                  builder: (_, __, p, mask) {
                    return MaskedImage(
                      asset: p.originalImage.imageBytes,
                      mask: mask,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
