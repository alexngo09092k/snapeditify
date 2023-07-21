import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

class QRProductForm extends QRFormBase {
  String product;

  QRProductForm({this.product = ""});

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return product;
  }

  @override
  bool validate() {
    return product.isNotEmpty;
  }
}
