import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_sms_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/pefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _SMSField {
  phoneNumber,
  message,
}

class SMSForm extends StatefulWidget {
  const SMSForm({super.key});

  @override
  State<SMSForm> createState() => _SMSFormState();
}

class _SMSFormState extends BaseFormState<SMSForm, QRSMSForm> {
  @override
  void initState() {
    form = QRSMSForm();
    super.initState();
  }

  void _onChanged(_SMSField field, String _) {
    switch (field) {
      case _SMSField.phoneNumber:
        form.phoneNumber = _;
        break;
      case _SMSField.message:
        form.message = _;
        break;
    }

    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.link,
      isDisabled: isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            // prefixIcon: PrefixIcon(icon: AppAssets.instance.gPhone),
            hintText: "Your phone number",
            onChanged:(_) => _onChanged(_SMSField.phoneNumber, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
            hintText: "Your message",
            onChanged:(_) => _onChanged(_SMSField.message, _),
          ),
        ],
      ),
    );
  }
}
