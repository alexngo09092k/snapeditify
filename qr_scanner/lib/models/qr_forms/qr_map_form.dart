// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

class QRMapForm extends QRFormBase {
  double latitude;
  double longitude;

  QRMapForm({
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "https://maps.google.com/local?q=$latitude,$longitude";
  }

  @override
  bool validate() {
    return true;
  }
}
