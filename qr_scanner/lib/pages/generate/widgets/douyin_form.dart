import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_douyin_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/pefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _DouyinField {
  username,
}

class DouyinForm extends StatefulWidget {
  const DouyinForm({super.key});

  @override
  State<DouyinForm> createState() => _DouyinFormState();
}

class _DouyinFormState extends BaseFormState<DouyinForm, QRDouyinForm> {
  @override
  void initState() {
    form = QRDouyinForm();
    super.initState();
  }

  void _onChanged(_DouyinField field, dynamic _) {
    switch (field) {
      case _DouyinField.username:
        form.username = _;
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
        onData: onData,
        qrType: QRType.douyin,
        isDisabled: isDisabled,
        child: Input(
          prefixIcon: PrefixIcon(icon: AppAssets.instance.gTiktok),
          hintText: "@username",
          onChanged: (_) => _onChanged(_DouyinField.username, _),
        ));
  }
}
