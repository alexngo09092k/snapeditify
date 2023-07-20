import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_format.dart';
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

abstract class BaseFormState<T extends StatefulWidget, Q extends QRFormBase> extends State<T> {
  final ValueNotifier<bool> isDisabled = ValueNotifier(true);
  QRFormat format = QRFormat.QrCode;
  late Q form;

  @override
  void initState() {
    checkDisabled();
    super.initState();
  }

  String? onData() => form.buildQRRawData();

  void onQRFormat(QRFormat _) {
    format = _;
    checkDisabled();
  }

  void checkDisabled() {
    isDisabled.value = !form.validate() || !format.barcode.isValid(form.buildQRRawData()!);
  }
}
