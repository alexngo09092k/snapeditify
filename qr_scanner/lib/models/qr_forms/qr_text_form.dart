import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

class QRTextForm extends QRFormBase {
  String text;

  QRTextForm({this.text = ""});

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return text;
  }

  @override
  bool validate() {
    return text.isNotEmpty;
  }
}
