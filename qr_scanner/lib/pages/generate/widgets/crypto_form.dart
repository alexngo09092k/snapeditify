import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class CryptoForm extends StatelessWidget {
  const CryptoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      qrType: QRType.crypto,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(hintText: "Amount"),
          Divider(),
          Input(hintText: "Reciever Cryptocurrency Address"),
          Divider(),
          Input(hintText: "Text Message"),
        ],
      ),
      onGenerate: () => {},
    );
  }
}
