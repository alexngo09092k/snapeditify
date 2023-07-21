import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_forms/qr_text_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class TextForm extends StatefulWidget {
  const TextForm({super.key});

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends BaseFormState<TextForm, QRTextForm> {
  @override
  void initState() {
    form = QRTextForm();
    super.initState();
  }

  void _onChanged(String _) {
    form.text = _;
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      onQRFormat: onQRFormat,
      qrType: QRType.text,
      isDisabled: isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            hintText: "Your text",
            onChanged: _onChanged,
          ),
        ],
      ),
    );
  }
}
