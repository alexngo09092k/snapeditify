import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_whatsapp_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/prefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _WhatsAppField {
  phone,
  message,
}

class WhatsAppForm extends StatefulWidget {
  const WhatsAppForm({super.key});

  @override
  State<WhatsAppForm> createState() => _WhatsAppFormState();
}

class _WhatsAppFormState extends BaseFormState<WhatsAppForm, QRWhatsAppForm> {
  @override
  void initState() {
    form = QRWhatsAppForm();
    super.initState();
  }

  void _onChanged(_WhatsAppField field, dynamic _) {
    switch (field) {
      case _WhatsAppField.phone:
        form.phone = _;
        break;
      case _WhatsAppField.message:
        form.message = _;
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
        onData: onData,
        qrType: QRType.whatsapp,
        isDisabled: isDisabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Input(
              prefixIcon: PrefixIcon(icon: AppAssets.instance.gWhatsapp),
              hintText: "Phone number",
              onChanged: (_) => _onChanged(_WhatsAppField.phone, _),
            ),
            SizedBox(height: AppDimensions.instance.padding),
            Input(
              prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
              hintText: "Message",
              onChanged: (_) => _onChanged(_WhatsAppField.message, _),
            ),
          ],
        ));
  }
}
