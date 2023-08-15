import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_facebook_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/pefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _FacebookField {
  type,
  username,
  share,
}

class FacebookForm extends StatefulWidget {
  const FacebookForm({super.key});

  @override
  State<FacebookForm> createState() => _FacebookFormState();
}

class _FacebookFormState extends BaseFormState<FacebookForm, QRFacebookForm> {
  @override
  void initState() {
    form = QRFacebookForm();
    super.initState();
  }

  void _onChanged(_FacebookField field, dynamic _) {
    switch (field) {
      case _FacebookField.type:
        form.type = _;
        break;
      case _FacebookField.share:
        form.shareURL = _;
        break;
      case _FacebookField.username:
        form.username = _;
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
      child: _QRFacebookTypeSelect(
        value: form.type,
        onChanged: (_) => _onChanged(_FacebookField.type, _),
        builder: (_, type) => type == QRFacebookType.profile
            ? Input(
                prefixIcon: PrefixIcon(icon: AppAssets.instance.gFacebook),
                hintText: "@username",
                onChanged: (_) => _onChanged(_FacebookField.username, _),
              )
            : Input(
                prefixIcon: PrefixIcon(icon: AppAssets.instance.gLink),
                hintText: "Your URL",
                onChanged: (_) => _onChanged(_FacebookField.share, _),
              ),
      ),
    );
  }
}

class _QRFacebookTypeSelect extends StatefulWidget {
  const _QRFacebookTypeSelect({
    required this.value,
    required this.onChanged,
    required this.builder,
  });
  final QRFacebookType value;
  final Function(QRFacebookType) onChanged;
  final Widget Function(BuildContext context, QRFacebookType) builder;

  @override
  State<_QRFacebookTypeSelect> createState() => __QRFacebookTypeSelectState();
}

class __QRFacebookTypeSelectState extends State<_QRFacebookTypeSelect> {
  QRFacebookType type = QRFacebookType.profile;

  @override
  void initState() {
    type = widget.value;
    super.initState();
  }

  void _onChanged(QRFacebookType? _) {
    if (_ == null) return;
    setState(() {
      type = _;
    });
    widget.onChanged(_);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...QRFacebookType.values
            .map(
              (_) => Row(
                children: [
                  Radio<QRFacebookType>(
                    value: _,
                    groupValue: type,
                    onChanged: _onChanged,
                  ),
                  Text(
                    _.label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            )
            .toList(),
        SizedBox(height: AppDimensions.instance.padding),
        widget.builder(context, type),
      ],
    );
  }
}
