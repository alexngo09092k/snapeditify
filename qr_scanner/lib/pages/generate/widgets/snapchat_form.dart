import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_snapchat_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _SnapChatField {
  type,
  username,
  tweet,
}

class SnapChatForm extends StatefulWidget {
  const SnapChatForm({super.key});

  @override
  State<SnapChatForm> createState() => _SnapChatFormState();
}

class _SnapChatFormState extends State<SnapChatForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(true);
  final QRSnapChatForm _form = QRSnapChatForm();

  @override
  void initState() {
    _isDisabled.value = !_form.validate();
    super.initState();
  }

  String? onData() => _form.buildQRRawData();

  void _onChanged(_SnapChatField field, dynamic _) {
    switch (field) {
      case _SnapChatField.type:
        _form.type = _;
        break;
      case _SnapChatField.tweet:
        _form.tweet = _;
        break;
      case _SnapChatField.username:
        _form.username = _;
        break;
    }

    _isDisabled.value = !_form.validate();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.email,
      isDisabled: _isDisabled,
      child: _QRSnapChatTypeSelect(
        value: _form.type,
        onChanged: (_) => _onChanged(_SnapChatField.type, _),
        builder: (_, type) => type == QRSnapChatType.profile
            ? Input(
                hintText: "@username",
                onChanged: (_) => _onChanged(_SnapChatField.username, _),
              )
            : Input(
                hintText: "Compose your tweet",
                onChanged: (_) => _onChanged(_SnapChatField.tweet, _),
              ),
      ),
    );
  }
}

class _QRSnapChatTypeSelect extends StatefulWidget {
  const _QRSnapChatTypeSelect({
    required this.value,
    required this.onChanged,
    required this.builder,
  });
  final QRSnapChatType value;
  final Function(QRSnapChatType) onChanged;
  final Widget Function(BuildContext context, QRSnapChatType) builder;

  @override
  State<_QRSnapChatTypeSelect> createState() => __QRSnapChatTypeSelectState();
}

class __QRSnapChatTypeSelectState extends State<_QRSnapChatTypeSelect> {
  QRSnapChatType type = QRSnapChatType.profile;

  @override
  void initState() {
    type = widget.value;
    super.initState();
  }

  void _onChanged(QRSnapChatType? _) {
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
          children: QRSnapChatType.values
              .map(
                (_) => Container(
                  margin: EdgeInsets.only(
                    right: AppDimensions.instance.padding,
                  ),
                  child: Row(
                    children: [
                      Radio<QRSnapChatType>(
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
