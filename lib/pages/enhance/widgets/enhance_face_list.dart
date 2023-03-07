import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_face_item.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/view_models/face_vm.dart';

class EnhanceFaceList extends StatelessWidget {
  const EnhanceFaceList({super.key});
  _onFace(FaceVM face) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AwesomeAppState.screen.height * 1 / 5,
      child: PropConsumer<IEnhanceProvider, int>(
        select: (p) => p.state.faces.length,
        builder: (_, __, p, ___) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => EnhanceFaceItem(
            face: p.state.faces.elementAt(index),
            onFace: _onFace,
          ),
          itemCount: p.state.faces.length,
        ),
      ),
    );
  }
}
