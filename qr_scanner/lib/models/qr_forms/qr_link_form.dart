import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';
import 'package:qr_scanner/utils/qr.dart';

class QRLinkForm extends QRFormBase {
  String url;

  QRLinkForm({this.url = ""});

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return url;
  }

  @override
  bool validate() {
    return QRUtils.instance.isURL(url);
  }
}
