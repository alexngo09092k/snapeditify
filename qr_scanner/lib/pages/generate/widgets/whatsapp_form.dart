import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_whatsapp_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _WhatsAppField {
  type,
  username,
  tweet,
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
      case _WhatsAppField.type:
        form.type = _;
        break;
      case _WhatsAppField.tweet:
        form.tweet = _;
        break;
      case _WhatsAppField.username:
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
      child: _QRWhatsAppTypeSelect(
        value: form.type,
        onChanged: (_) => _onChanged(_WhatsAppField.type, _),
        builder: (_, type) => type == QRWhatsAppType.profile
            ? Input(
                hintText: "@username",
                onChanged: (_) => _onChanged(_WhatsAppField.username, _),
              )
            : Input(
                hintText: "Compose your tweet",
                onChanged: (_) => _onChanged(_WhatsAppField.tweet, _),
              ),
      ),
    );
  }
}

class _QRWhatsAppTypeSelect extends StatefulWidget {
  const _QRWhatsAppTypeSelect({
    required this.value,
    required this.onChanged,
    required this.builder,
  });
  final QRWhatsAppType value;
  final Function(QRWhatsAppType) onChanged;
  final Widget Function(BuildContext context, QRWhatsAppType) builder;

  @override
  State<_QRWhatsAppTypeSelect> createState() => __QRWhatsAppTypeSelectState();
}

class __QRWhatsAppTypeSelectState extends State<_QRWhatsAppTypeSelect> {
  QRWhatsAppType type = QRWhatsAppType.profile;

  @override
  void initState() {
    type = widget.value;
    super.initState();
  }

  void _onChanged(QRWhatsAppType? _) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: QRWhatsAppType.values
              .map(
                (_) => Container(
                  margin: EdgeInsets.only(
                    right: AppDimensions.instance.padding,
                  ),
                  child: Row(
                    children: [
                      Radio<QRWhatsAppType>(
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
                ),
              )
              .toList(),
        ),
        widget.builder(context, type),
      ],
    );
  }
}
