import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_snapchat_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/pefix_icon.dart';
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

class _SnapChatFormState extends BaseFormState<SnapChatForm, QRSnapChatForm> {
  @override
  void initState() {
    form = QRSnapChatForm();
    super.initState();
  }

  void _onChanged(_SnapChatField field, dynamic _) {
    switch (field) {
      case _SnapChatField.type:
        form.type = _;
        break;
      case _SnapChatField.tweet:
        form.tweet = _;
        break;
      case _SnapChatField.username:
        form.username = _;
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.snapchat,
      isDisabled: isDisabled,
      child: _QRSnapChatTypeSelect(
        value: form.type,
        onChanged: (_) => _onChanged(_SnapChatField.type, _),
        builder: (_, type) => type == QRSnapChatType.profile
            ? Input(
                prefixIcon: PrefixIcon(icon: AppAssets.instance.gSnapChat),
                hintText: "@username",
                onChanged: (_) => _onChanged(_SnapChatField.username, _),
              )
            : Input(
                prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
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
        ...QRSnapChatType.values
            .map(
              (_) => Row(
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
            )
            .toList(),
        SizedBox(height: AppDimensions.instance.padding),
        widget.builder(context, type),
      ],
    );
  }
}
