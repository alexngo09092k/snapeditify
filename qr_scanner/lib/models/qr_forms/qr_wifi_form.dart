import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

class QRWifiForm extends QRFormBase {
  String ssid;
  Encryption encryption;
  String password;
  bool hidden;

  QRWifiForm({
    this.ssid = "",
    this.encryption = Encryption.wpa,
    this.password = "",
    this.hidden = false,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "WIFI:T:${encryption.value};S:$ssid;P:$password;H:$hidden;;";
  }

  @override
  bool validate() {
    return ssid.isNotEmpty;
  }
}

enum Encryption {
  none,
  wpa,
  wep,
}

extension EncryptionEx on Encryption {
  String get label {
    switch (this) {
      case Encryption.wep:
        return "WEP";
      case Encryption.wpa:
        return "WPA/WPA2";
      case Encryption.none:
        return "None";
    }
  }

  String get value {
    switch (this) {
      case Encryption.wpa:
        return "WPA";
      case Encryption.wep:
        return "WEP";
      case Encryption.none:
        return "nopass";
    }
  }
}
