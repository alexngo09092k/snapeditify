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
    return QRUtils.instance.isPhoneNumber(phone);
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'https://maps.google.com',
      'https://www.maps.google.com',
      'http://maps.google.com',
      'http://www.maps.google.com/',
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}
