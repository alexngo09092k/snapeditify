import 'package:flutter/material.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_face_list.dart';

class EnhanceResult extends StatefulWidget {
  const EnhanceResult({super.key});

  @override
  State<EnhanceResult> createState() => _EnhanceResultState();
}

class _EnhanceResultState extends State<EnhanceResult> {
  @override
  Widget build(BuildContext context) {
    return const EnhanceFaceList();
  }
}
