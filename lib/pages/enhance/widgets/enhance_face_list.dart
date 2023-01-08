import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/pages/enhance/widgets/enhance_face_item.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';
import 'package:snapedit/view_models/face_vm.dart';

class EnhanceFaceList extends StatelessWidget {
  const EnhanceFaceList({super.key, required this.provider});
  final EnhanceProvider provider;

  _onFace(FaceVM face) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AwesomeAppState.screen.height * 1 / 5,
      child: BasePropConsumer<EnhanceProvider, int>(
        listenable: provider,
        select: (p) => p.state.faces.length + 1,
        builder: (_, __, p, ___) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => EnhanceFaceItem(
            provider: provider,
            face: p.state.faces.elementAt(index),
            onFace: _onFace,
          ),
          itemCount: p.state.faces.length,
        ),
      ),
    );
  }
}
