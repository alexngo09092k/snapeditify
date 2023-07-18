import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class TiktokForm extends StatelessWidget {
  const TiktokForm({super.key});

  String onData() {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.store,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(hintText: "Tiktok Link"),
        ],
      ),
    );
  }
}
