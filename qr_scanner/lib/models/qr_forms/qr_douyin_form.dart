// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRDouyinType {
  profile,
}

class QRDouyinForm extends QRFormBase {
  String username;

  QRDouyinForm({
    this.username = "",
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "https://www.douyin.com/$username";
  }

  @override
  bool validate() {
    return username.isNotEmpty;
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'https://www.douyin.com',
      'https://douyin.com',
      'http://douyin.com',
      'douyin:',
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}

extension QRDouyinTypeEx on QRDouyinType {
  String get label {
    switch (this) {
      case QRDouyinType.profile:
        return "Link to your profile";
    }
  }
}
