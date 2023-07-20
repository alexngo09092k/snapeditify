import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_tiktok_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _TikTokField {
  type,
  username,
  tweet,
}

class TikTokForm extends StatefulWidget {
  const TikTokForm({super.key});

  @override
  State<TikTokForm> createState() => _TikTokFormState();
}

class _TikTokFormState extends BaseFormState<TikTokForm, QRTikTokForm> {
  @override
  void initState() {
    form = QRTikTokForm();
    super.initState();
  }

  void _onChanged(_TikTokField field, dynamic _) {
    switch (field) {
      case _TikTokField.type:
        form.type = _;
        break;
      case _TikTokField.tweet:
        form.tweet = _;
        break;
      case _TikTokField.username:
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
      child: _QRTikTokTypeSelect(
        value: form.type,
        onChanged: (_) => _onChanged(_TikTokField.type, _),
        builder: (_, type) => type == QRTikTokType.profile
            ? Input(
                hintText: "@username",
                onChanged: (_) => _onChanged(_TikTokField.username, _),
              )
            : Input(
                hintText: "Compose your tweet",
                onChanged: (_) => _onChanged(_TikTokField.tweet, _),
              ),
      ),
    );
  }
}

class _QRTikTokTypeSelect extends StatefulWidget {
  const _QRTikTokTypeSelect({
    required this.value,
    required this.onChanged,
    required this.builder,
  });
  final QRTikTokType value;
  final Function(QRTikTokType) onChanged;
  final Widget Function(BuildContext context, QRTikTokType) builder;

  @override
  State<_QRTikTokTypeSelect> createState() => __QRTikTokTypeSelectState();
}

class __QRTikTokTypeSelectState extends State<_QRTikTokTypeSelect> {
  QRTikTokType type = QRTikTokType.profile;

  @override
  void initState() {
    type = widget.value;
    super.initState();
  }

  void _onChanged(QRTikTokType? _) {
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
          children: QRTikTokType.values
              .map(
                (_) => Container(
                  margin: EdgeInsets.only(
                    right: AppDimensions.instance.padding,
                  ),
                  child: Row(
                    children: [
                      Radio<QRTikTokType>(
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
