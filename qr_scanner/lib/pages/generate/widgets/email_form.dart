import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_email.form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/prefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _EmailField {
  email,
  subject,
  message,
}

class EmailForm extends StatefulWidget {
  const EmailForm({super.key});

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends BaseFormState<EmailForm, QREmailForm> {
  @override
  void initState() {
    form = QREmailForm();
    super.initState();
  }

  void _onChanged(_EmailField field, String _) {
    switch (field) {
      case _EmailField.email:
        form.email = _;
        break;
      case _EmailField.message:
        form.message = _;
        break;
      case _EmailField.subject:
        form.subject = _;
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.email,
      isDisabled: isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gEmail),
            hintText: "E-mail recipient",
            onChanged: (_) => _onChanged(_EmailField.email, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
            hintText: "Subject",
            onChanged: (_) => _onChanged(_EmailField.subject, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
            hintText: "Message",
            onChanged: (_) => _onChanged(_EmailField.message, _),
          ),
        ],
      ),
    );
  }
}
