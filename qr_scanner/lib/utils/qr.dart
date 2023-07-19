class QRUtils {
  static final QRUtils _instance = QRUtils._internal();

  static QRUtils get instance => _instance;

  QRUtils._internal();

  /// Validate

  bool isURL(String url) {
    const String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    return RegExp(pattern).hasMatch(url);
  }

  bool isEmail(String email) {
    const String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return RegExp(pattern).hasMatch(email);
  }

  bool isWalletAddress(String address) {
    return address.isNotEmpty;
  }

  bool isPhoneNumber(String phoneNumber) {
    const String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    return RegExp(pattern).hasMatch(phoneNumber);
  }
}
