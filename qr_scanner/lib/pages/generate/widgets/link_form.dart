import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_link_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/prefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class LinkForm extends StatefulWidget {
  const LinkForm({super.key});

  @override
  State<LinkForm> createState() => _LinkFormState();
}

class _LinkFormState extends BaseFormState<LinkForm, QRLinkForm> {
  @override
  void initState() {
    form = QRLinkForm();
    super.initState();
  }

  void _onChanged(String _) {
    form.url = _;

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
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gLink),
            hintText: "Put your link here",
            onChanged: _onChanged,
          ),
        ],
      ),
    );
  }
}
