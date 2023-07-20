import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_telegram_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _TelegramField {
  type,
  username,
  tweet,
}

class TelegramForm extends StatefulWidget {
  const TelegramForm({super.key});

  @override
  State<TelegramForm> createState() => _TelegramFormState();
}

class _TelegramFormState extends BaseFormState<TelegramForm, QRTelegramForm> {
  @override
  void initState() {
    form = QRTelegramForm();
    super.initState();
  }

  void _onChanged(_TelegramField field, dynamic _) {
    switch (field) {
      case _TelegramField.type:
        form.type = _;
        break;
      case _TelegramField.tweet:
        form.tweet = _;
        break;
      case _TelegramField.username:
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
      child: _QRTelegramTypeSelect(
        value: form.type,
        onChanged: (_) => _onChanged(_TelegramField.type, _),
        builder: (_, type) => type == QRTelegramType.profile
            ? Input(
                hintText: "@username",
                onChanged: (_) => _onChanged(_TelegramField.username, _),
              )
            : Input(
                hintText: "Compose your tweet",
                onChanged: (_) => _onChanged(_TelegramField.tweet, _),
              ),
      ),
    );
  }
}

class _QRTelegramTypeSelect extends StatefulWidget {
  const _QRTelegramTypeSelect({
    required this.value,
    required this.onChanged,
    required this.builder,
  });
  final QRTelegramType value;
  final Function(QRTelegramType) onChanged;
  final Widget Function(BuildContext context, QRTelegramType) builder;

  @override
  State<_QRTelegramTypeSelect> createState() => __QRTelegramTypeSelectState();
}

class __QRTelegramTypeSelectState extends State<_QRTelegramTypeSelect> {
  QRTelegramType type = QRTelegramType.profile;

  @override
  void initState() {
    type = widget.value;
    super.initState();
  }

  void _onChanged(QRTelegramType? _) {
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
          children: QRTelegramType.values
              .map(
                (_) => Container(
                  margin: EdgeInsets.only(
                    right: AppDimensions.instance.padding,
                  ),
                  child: Row(
                    children: [
                      Radio<QRTelegramType>(
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
