// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';
import 'package:qr_scanner/utils/qr.dart';

class QRWhatsAppForm extends QRFormBase {
  String phone;
  String message;

  QRWhatsAppForm({
    this.phone = "",
    this.message = "",
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "https://api.whatsapp.com/send?phone=$phone&text=$message";
  }

  @override
  bool validate() {
    return QRUtils.instance.isPhoneNumber(phone) && message.isNotEmpty;
  }

  static bool isQR(String rawData) {
    String check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'https://api.whatsapp.com',
      'https://www.api.whatsapp.com',
      'http://api.whatsapp.com',
      'http://www.api.whatsapp.com',
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}
