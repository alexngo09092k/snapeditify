import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class FacebookForm extends StatefulWidget {
  const FacebookForm({super.key});

  @override
  State<FacebookForm> createState() => _FacebookFormState();
}

class _FacebookFormState extends State<FacebookForm> {
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
          Input(hintText: "Facebook Link"),
        ],
      ),
    );
  }
}
