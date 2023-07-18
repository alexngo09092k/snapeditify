import 'package:qr_scanner/models/qr_type.dart';

class QRUtils {
  static final QRUtils _instance = QRUtils._internal();

  static QRUtils get instance => _instance;

  QRUtils._internal();

  /// Validate

  bool isURL(String url) {
    const String reg = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    return RegExp(reg).hasMatch(url);
  }

  bool isEmail(String email) {
    const String reg = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return RegExp(reg).hasMatch(email);
  }

  String buildRawData(QRType qrType, String data) {
    switch (qrType) {
      case QRType.link:
        if (isURL(data)) return data;
      case QRType.email:
        if(isEmail(data)) return data;
      default:
        return data;
    }
    return data;
  }
}
