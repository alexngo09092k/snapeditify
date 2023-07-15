import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class URLForm extends StatelessWidget {
  const URLForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onGenerate: () => {},
      qrType: QRType.link,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(hintText: "Put your link here"),
        ],
      ),
    );
  }
}
