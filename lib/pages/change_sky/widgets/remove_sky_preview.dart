import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/providers/change_sky/change_sky_provider.dart';
import 'package:snapeditify/widgets/app_use/masked_image.dart';

class RemoveSkyPreview extends StatelessWidget {
  const RemoveSkyPreview({super.key});
  @override
  Widget build(BuildContext context) {
    return PropConsumer<IChangeSkyProvider, Uint8List>(
      select: (_) => _.state.mask,
      builder: (_, __, p, mask) {
        return MaskedImage(
          asset: p.originalImage.imageBytes,
          mask: mask,
        );
      },
    );
  }
}
