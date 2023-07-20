// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';
import 'package:qr_scanner/utils/qr.dart';

class QRSMSForm extends QRFormBase {
  String phoneNumber;
  String message;

  QRSMSForm({
    this.phoneNumber = "",
    this.message = "",
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "SMSTO:$phoneNumber:$message";
  }

  @override
  bool validate() {
    return QRUtils.instance.isPhoneNumber(phoneNumber) && message.isNotEmpty;
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'smsto:',
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}
