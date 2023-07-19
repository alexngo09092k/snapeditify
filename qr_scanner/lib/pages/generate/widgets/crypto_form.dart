import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_crypto_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

enum _CryptoField {
  cryptocurrency,
  amount,
  receiver,
  message,
}

class CryptoForm extends StatefulWidget {
  const CryptoForm({super.key});

  @override
  State<CryptoForm> createState() => _CryptoFormState();
}

class _CryptoFormState extends State<CryptoForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(true);
  final QRCryptoForm _form = QRCryptoForm();

  @override
  void initState() {
    _isDisabled.value = !_form.validate();
    super.initState();
  }

  String? onData() => _form.buildQRRawData();

  void _onChanged(_CryptoField field, dynamic _) {
    switch (field) {
      case _CryptoField.amount:
        _form.amount = int.tryParse(_) ?? 0;
        break;
      case _CryptoField.cryptocurrency:
        _form.cryptocurrency = _ ?? Cryptocurrency.bitcoin;
        break;
      case _CryptoField.receiver:
        _form.receiver = _;
        break;
      case _CryptoField.message:
        _form.message = _;
        break;
      default:
        break;
    }
    
    _isDisabled.value = !_form.validate();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.crypto,
      isDisabled: _isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            hintText: "Amount",
            onChanged: (_) => _onChanged(_CryptoField.amount, _),
          ),
          Input(
            hintText: "Receiver",
            onChanged: (_) => _onChanged(_CryptoField.receiver, _),
          ),
          Input(
            hintText: "Message",
            onChanged: (_) => _onChanged(_CryptoField.message, _),
          ),
          _CryptoSelect(
            value: _form.cryptocurrency,
            onChanged: (_) => _onChanged(_CryptoField.cryptocurrency, _),
          ),
        ],
      ),
    );
  }
}

class _CryptoSelect extends StatefulWidget {
  const _CryptoSelect({required this.onChanged, required this.value});
  final Function(Cryptocurrency) onChanged;
  final Cryptocurrency value;

  @override
  State<_CryptoSelect> createState() => __CryptoSelectState();
}

class __CryptoSelectState extends State<_CryptoSelect> {
  Cryptocurrency currency = Cryptocurrency.bitcoin;

  @override
  void initState() {
    currency = widget.value;
    super.initState();
  }

  void _onChanged(Cryptocurrency cryptocurrency) {
    widget.onChanged(cryptocurrency);
    setState(() {
      currency = cryptocurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Cryptocurrency.values.length,
        itemBuilder: (_, __) => GestureDetector(
          onTap: () => _onChanged(Cryptocurrency.values[__]),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
              border: Border.all(
                width: 3,
                color: currency == Cryptocurrency.values[__]
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).disabledColor,
              ),
            ),
            margin: EdgeInsets.symmetric(
              vertical: AppDimensions.instance.padding,
              horizontal: AppDimensions.instance.paddingX(0.5),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.instance.padding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomIcon(
                  Cryptocurrency.values[__].image,
                  size: AppDimensions.instance.iconX(1.5),
                  normal: true,
                ),
                SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                Text(
                  Cryptocurrency.values[__].label,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
