import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_face_list.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';

class EnhanceResult extends StatefulWidget {
  const EnhanceResult({super.key, required this.provider});
  final EnhanceProvider provider;

  @override
  State<EnhanceResult> createState() => _EnhanceResultState();
}

class _EnhanceResultState extends State<EnhanceResult> {
  @override
  void initState() {
    super.initState();
  }

  void _onChangedResult(int? index) {
    if (index == null) return;
    widget.provider.state.enhancedImages[index].onSelect();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Debug.log(widget.provider.state.enhancedImages);
    return EnhanceFaceList(provider: widget.provider);
  }
}
