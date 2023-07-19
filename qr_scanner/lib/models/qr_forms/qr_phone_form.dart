import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';
import 'package:qr_scanner/utils/qr.dart';

class QRPhoneForm extends QRFormBase {
  String phone;

  QRPhoneForm({this.phone = ""});

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return phone;
  }

  @override
  bool validate() {
    return QRUtils.instance.isURL(phone);
  }
}
