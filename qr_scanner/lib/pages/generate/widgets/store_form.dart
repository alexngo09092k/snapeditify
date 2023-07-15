import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class StoreForm extends StatelessWidget {
  const StoreForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onGenerate: () => {},
      qrType: QRType.store,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(hintText: "Link for App Store"),
          Divider(),
          Input(hintText: "Link for Google Play"),
          Divider(),
          Input(hintText: "Link for other devices"),
        ],
      ),
    );
  }
}
