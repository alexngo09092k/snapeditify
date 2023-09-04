import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/change_bg/change_bg_provider.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/masked_image.dart';
import 'package:snapeditify/widgets/app_use/widgets_to_image.dart';

class RemoveBGImageResult extends StatefulWidget {
  const RemoveBGImageResult({super.key});

  @override
  State<RemoveBGImageResult> createState() => _RemoveBGImageResultState();
}

class _RemoveBGImageResultState extends State<RemoveBGImageResult> {
  late WidgetsToImageController _controller;

  @override
  void initState() {
    _controller = WidgetsToImageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Center(
        child: WidgetsToImage(
          controller: _controller,
          child: PropConsumer<ChangeBGProvider, Color?>(
            select: (_) => _.state.bgColor,
            builder: (_, child, __, color) {
              if (color == null) return const SizedBox();
              return Container(
                decoration: BoxDecoration(
                  color: color,
                  image: DecorationImage(
                    image: Image.asset(AppAssets.instance.bgTransparent).image,
                    fit: BoxFit.fill,
                  ),
                ),
                child: child,
              );
            },
            child: Center(
              child: PropConsumer<ChangeBGProvider, double>(
                select: (_) => _.state.image.ratio,
                builder: (_, child, __, ratio) {
                  return AspectRatio(
                    aspectRatio: ratio,
                    child: child,
                  );
                },
                child: PropConsumer<ChangeBGProvider, Uint8List>(
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
