// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/view_models/face_vm.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';

class EnhanceFaceItem extends StatelessWidget {
  const EnhanceFaceItem({super.key, required this.provider, required this.face, required this.onFace});
  final EnhanceProvider provider;
  final FaceVM face;
  final Function(FaceVM) onFace;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onFace(face),
      child: Container(
        child: Column(
          children: [
            BasePropConsumer<EnhanceProvider, int>(
              listenable: provider,
              select: (p) => p.state.enhancedImageIndex,
              builder: (_, __, p, ___) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                child: Container(
                  child: Image.network(
                    face.png[p.state.enhancedImageIndex],
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
