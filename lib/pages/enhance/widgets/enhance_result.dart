import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return EnhanceFaceList(provider: widget.provider);
  }
}
