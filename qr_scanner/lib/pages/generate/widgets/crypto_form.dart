import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_crypto_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/prefix_icon.dart';
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

class _CryptoFormState extends BaseFormState<CryptoForm, QRCryptoForm> {
  @override
  void initState() {
    form = QRCryptoForm();
    super.initState();
  }

  void _onChanged(_CryptoField field, dynamic _) {
    switch (field) {
      case _CryptoField.amount:
        form.amount = int.tryParse(_) ?? 0;
        break;
      case _CryptoField.cryptocurrency:
        form.cryptocurrency = _ ?? Cryptocurrency.bitcoin;
        setState(() {});
        break;
      case _CryptoField.receiver:
        form.receiver = _;
        break;
      case _CryptoField.message:
        form.message = _;
        break;
      default:
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.crypto,
      isDisabled: isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            prefixIcon:
                PrefixIcon(icon: form.cryptocurrency.image, normal: true),
            hintText: "Amount",
            onChanged: (_) => _onChanged(_CryptoField.amount, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
            hintText: "Receiver",
            onChanged: (_) => _onChanged(_CryptoField.receiver, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
            hintText: "Message",
            onChanged: (_) => _onChanged(_CryptoField.message, _),
          ),
          SizedBox(height: AppDimensions.instance.paddingX(1.5)),
          _CryptoSelect(
            value: form.cryptocurrency,
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
    return Wrap(
      alignment: WrapAlignment.start,
      children: Cryptocurrency.values
          .map<Widget>((_) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _onChanged(_),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                        border: Border.all(
                          width: 1,
                          color: currency == _
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).disabledColor,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: AppDimensions.instance.paddingX(0.5),
                        horizontal: AppDimensions.instance.paddingX(0.5),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.instance.padding,
                        vertical: AppDimensions.instance.paddingX(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomIcon(
                            _.image,
                            size: AppDimensions.instance.iconX(1.5),
                            normal: true,
                          ),
                          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                          Text(
                            _.label,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: currency == _
                                      ? Theme.of(context).colorScheme.primary
                                      : null,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
