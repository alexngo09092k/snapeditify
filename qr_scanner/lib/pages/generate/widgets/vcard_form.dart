import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_forms/qr_vcard_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _FieldVCard {
  firstName,
  lastName,
  mobile,
  phone,
  fax,
  email,
  company,
  job,
  street,
  city,
  zip,
  state,
  country,
  website,
}

class VCardForm extends StatefulWidget {
  const VCardForm({super.key});

  @override
  State<VCardForm> createState() => _VCardFormState();
}

class _VCardFormState extends State<VCardForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(false);
  final QRVCardForm _form = QRVCardForm();

  @override
  void initState() {
    _isDisabled.value = !_form.validate();
    super.initState();
  }

  String? onData() => _form.buildQRRawData();

  void _onChanged(_FieldVCard field, dynamic _) {
    if (_ == null) return;
    switch (field) {
      case _FieldVCard.firstName:
        _form.firstName = _;
        break;
      case _FieldVCard.lastName:
        _form.lastName = _;
        break;
      case _FieldVCard.company:
        _form.company = _;
        break;
      case _FieldVCard.job:
        _form.job = _;
        break;
      case _FieldVCard.street:
        _form.street = _;
        break;
      case _FieldVCard.city:
        _form.city = _;
        break;
      case _FieldVCard.state:
        _form.state = _;
        break;
      case _FieldVCard.zip:
        _form.zip = int.tryParse(_) ?? 0;
        break;
      case _FieldVCard.country:
        _form.country = _;
        break;
      case _FieldVCard.phone:
        _form.phone = _;
        break;
      case _FieldVCard.mobile:
        _form.mobile = _;
        break;
      case _FieldVCard.fax:
        _form.fax = _;
        break;
      case _FieldVCard.email:
        _form.email = _;
        break;
      case _FieldVCard.website:
        _form.website = _;
        break;
    }

    _isDisabled.value = !_form.validate();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.vcard,
      isDisabled: _isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          Row(
            children: [
              Expanded(
                child: Input(
                  hintText: "First name",
                  onChanged: (_) => _onChanged(_FieldVCard.firstName, _),
                ),
              ),
              Expanded(
                child: Input(
                  hintText: "Last name",
                  onChanged: (_) => _onChanged(_FieldVCard.lastName, _),
                ),
              )
            ],
          ),
          const Divider(),
          Input(
            hintText: "Phone number (Mobile)",
            onChanged: (_) => _onChanged(_FieldVCard.mobile, _),
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: Input(
                  hintText: "Phone number",
                  onChanged: (_) => _onChanged(_FieldVCard.phone, _),
                ),
              ),
              Expanded(
                child: Input(
                  hintText: "Fax",
                  onChanged: (_) => _onChanged(_FieldVCard.fax, _),
                ),
              ),
            ],
          ),
          const Divider(),
          Input(
            hintText: "your@gmail.com",
            onChanged: (_) => _onChanged(_FieldVCard.email, _),
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: Input(
                  hintText: "Company",
                  onChanged: (_) => _onChanged(_FieldVCard.company, _),
                ),
              ),
              Expanded(
                child: Input(
                  hintText: "Your Job",
                  onChanged: (_) => _onChanged(_FieldVCard.job, _),
                ),
              ),
            ],
          ),
          const Divider(),
          Input(
            hintText: "Street",
            onChanged: (_) => _onChanged(_FieldVCard.street, _),
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Input(
                  hintText: "City",
                  onChanged: (_) => _onChanged(_FieldVCard.city, _),
                ),
              ),
              Expanded(
                flex: 1,
                child: Input(
                  hintText: "Zip",
                  onChanged: (_) => _onChanged(_FieldVCard.zip, _),
                ),
              ),
            ],
          ),
          const Divider(),
          Input(
            hintText: "State",
            onChanged: (_) => _onChanged(_FieldVCard.state, _),
          ),
          const Divider(),
          Input(
            hintText: "Country",
            onChanged: (_) => _onChanged(_FieldVCard.country, _),
          ),
          const Divider(),
          Input(
            hintText: "Your website",
            onChanged: (_) => _onChanged(_FieldVCard.website, _),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
