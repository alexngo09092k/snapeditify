import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/view_models/face_vm.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';

class EnhanceFaceItem extends StatelessWidget {
  const EnhanceFaceItem({super.key, required this.provider, required this.face});
  final EnhanceProvider provider;
  final FaceVM face;

  @override
  Widget build(BuildContext context) {
    final imageWidget = BasePropConsumer<EnhanceProvider, int>(
      listenable: provider,
      select: (p) => p.state.enhancedImageIndex,
      builder: (_, __, p, ___) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: SizedBox(
          width: 60,
          height: 60,
          child: Center(
            child: Image.network(face.png[p.state.enhancedImageIndex]),
          ),
        ),
      ),
    );
    return
        //  BasePropConsumer<EnhanceProvider, bool>(
        //   listenable: provider,
        //   select: (p) => p.state.faces[face.faceId].isSelected,
        //   builder: (_, __, p, ___) =>
        GestureDetector(
      onTap: face.onSelect,
      child: Container(
        width: 60,
        height: 60,
        color: Colors.red,
        child: imageWidget,
      ),
      // ),
    );
  }
}
