import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/pages/enhance/widgets/enhance_face_item.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';

class EnhanceFaceList extends StatelessWidget {
  const EnhanceFaceList({super.key, required this.provider});
  final EnhanceProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BasePropConsumer<EnhanceProvider, int>(
        listenable: provider,
        select: (p) => p.state.faces.length,
        builder: (_, __, p, ___) => ListView.builder(
          itemBuilder: (_, index) => EnhanceFaceItem(
            provider: provider,
            face: p.state.faces.elementAt(index),
          ),
          itemCount: p.state.faces.length,
        ),
      ),
    );
  }
}
