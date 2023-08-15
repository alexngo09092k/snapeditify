// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

class QRTikTokForm extends QRFormBase {
  String username;

  QRTikTokForm({
    this.username = "",
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "https://tiktok.com/$username";
  }

  @override
  bool validate() {
    return username.isNotEmpty;
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'https://tiktok.com',
      'https://www.tiktok.com',
      'http://www.tiktok.com',
      'http://tiktok.com',
      'tiktok:'
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}
