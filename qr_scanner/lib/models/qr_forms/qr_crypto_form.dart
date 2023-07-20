import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';
import 'package:qr_scanner/utils/qr.dart';

class QRCryptoForm extends QRFormBase {
  Cryptocurrency cryptocurrency;
  int amount;
  String receiver;
  String message;

  QRCryptoForm({
    this.cryptocurrency = Cryptocurrency.bitcoin,
    this.amount = 0,
    this.receiver = "",
    this.message = "",
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "${cryptocurrency.name}:$receiver?amount=$amount&message=$message";
  }

  @override
  bool validate() {
    return QRUtils.instance.isWalletAddress(receiver) && amount > 0;
  }
  
  static bool isQR(String rawData) {
    final String check = rawData.toLowerCase().trim();
    const List<Cryptocurrency> checkList = Cryptocurrency.values;
    return checkList.any((element) => check.startsWith('${element.name}:'));
  }
}

enum Cryptocurrency {
  bitcoin,
  bitcoincash,
  ether,
  litecoin,
  dash,
  bnb,
  usdt,
}

extension CryptocurrencyEx on Cryptocurrency {
  String get image {
    switch (this) {
      case Cryptocurrency.bitcoin:
        return AppAssets.instance.bitcoin;
      case Cryptocurrency.bitcoincash:
        return AppAssets.instance.bitcoincash;
      case Cryptocurrency.ether:
        return AppAssets.instance.ether;
      case Cryptocurrency.litecoin:
        return AppAssets.instance.litecoin;
      case Cryptocurrency.dash:
        return AppAssets.instance.dash;
      case Cryptocurrency.bnb:
        return AppAssets.instance.bnb;
      case Cryptocurrency.usdt:
        return AppAssets.instance.usdt;
    }
  }

  String get label {
    switch (this) {
      case Cryptocurrency.bitcoin:
        return "Bitcoin";
      case Cryptocurrency.bitcoincash:
        return "Bitcoin Cash";
      case Cryptocurrency.ether:
        return "Ethereum";
      case Cryptocurrency.litecoin:
        return "Lifte Coin";
      case Cryptocurrency.dash:
        return "Dash";
      case Cryptocurrency.bnb:
        return "Binance Coin";
      case Cryptocurrency.usdt:
        return "Tether Coin";
    }
  }
}
