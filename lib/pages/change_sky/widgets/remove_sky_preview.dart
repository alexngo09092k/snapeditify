import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/change_sky/change_sky_provider.dart';
import 'package:snapeditify/widgets/app_use/masked_image.dart';
import 'package:snapeditify/widgets/app_use/widgets_to_image.dart';

class RemoveSkyPreview extends StatefulWidget {
  const RemoveSkyPreview({super.key});

  @override
  State<RemoveSkyPreview> createState() => _RemoveSkyPreviewState();
}

class _RemoveSkyPreviewState extends ProviderStateObserver<RemoveSkyPreview, IChangeSkyProvider> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
            child: PropConsumer<IChangeSkyProvider, double>(
              select: (_) => _.state.image.ratio,
              builder: (_, child, __, ratio) {
                return AspectRatio(
                  aspectRatio: ratio,
                  child: child,
                );
              },
              child: PropConsumer<IChangeSkyProvider, Uint8List>(
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
    );
  }
}
