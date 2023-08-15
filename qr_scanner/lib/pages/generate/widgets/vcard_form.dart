import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_vcard_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
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

class _VCardFormState extends BaseFormState<VCardForm, QRVCardForm> {
  @override
  void initState() {
    form = QRVCardForm();
    super.initState();
  }

  void _onChanged(_FieldVCard field, dynamic _) {
    if (_ == null) return;
    switch (field) {
      case _FieldVCard.firstName:
        form.firstName = _;
        break;
      case _FieldVCard.lastName:
        form.lastName = _;
        break;
      case _FieldVCard.company:
        form.company = _;
        break;
      case _FieldVCard.job:
        form.job = _;
        break;
      case _FieldVCard.street:
        form.street = _;
        break;
      case _FieldVCard.city:
        form.city = _;
        break;
      case _FieldVCard.state:
        form.state = _;
        break;
      case _FieldVCard.zip:
        form.zip = int.tryParse(_) ?? 0;
        break;
      case _FieldVCard.country:
        form.country = _;
        break;
      case _FieldVCard.phone:
        form.phone = _;
        break;
      case _FieldVCard.mobile:
        form.mobile = _;
        break;
      case _FieldVCard.fax:
        form.fax = _;
        break;
      case _FieldVCard.email:
        form.email = _;
        break;
      case _FieldVCard.website:
        form.website = _;
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.vcard,
      isDisabled: isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Input(
                  hintText: "First name",
                  onChanged: (_) => _onChanged(_FieldVCard.firstName, _),
                ),
              ),
              SizedBox(width: AppDimensions.instance.padding),
              Expanded(
                child: Input(
                  hintText: "Last name",
                  onChanged: (_) => _onChanged(_FieldVCard.lastName, _),
                ),
              )
            ],
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            hintText: "Phone number (Mobile)",
            onChanged: (_) => _onChanged(_FieldVCard.mobile, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Row(
            children: [
              Expanded(
                child: Input(
                  hintText: "Phone number",
                  onChanged: (_) => _onChanged(_FieldVCard.phone, _),
                ),
              ),
              SizedBox(width: AppDimensions.instance.padding),
              Expanded(
                child: Input(
                  hintText: "Fax",
                  onChanged: (_) => _onChanged(_FieldVCard.fax, _),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            hintText: "your@gmail.com",
            onChanged: (_) => _onChanged(_FieldVCard.email, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Row(
            children: [
              Expanded(
                child: Input(
                  hintText: "Company",
                  onChanged: (_) => _onChanged(_FieldVCard.company, _),
                ),
              ),
              SizedBox(width: AppDimensions.instance.padding),
              Expanded(
                child: Input(
                  hintText: "Your Job",
                  onChanged: (_) => _onChanged(_FieldVCard.job, _),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            hintText: "Street",
            onChanged: (_) => _onChanged(_FieldVCard.street, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Input(
                  hintText: "City",
                  onChanged: (_) => _onChanged(_FieldVCard.city, _),
                ),
              ),
              SizedBox(width: AppDimensions.instance.padding),
              Expanded(
                flex: 1,
                child: Input(
                  hintText: "Zip",
                  onChanged: (_) => _onChanged(_FieldVCard.zip, _),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            hintText: "State",
            onChanged: (_) => _onChanged(_FieldVCard.state, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            hintText: "Country",
            onChanged: (_) => _onChanged(_FieldVCard.country, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            hintText: "Your website",
            onChanged: (_) => _onChanged(_FieldVCard.website, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
        ],
      ),
    );
  }
}
