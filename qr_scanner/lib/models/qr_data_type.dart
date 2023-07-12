import 'package:qr_scanner/common/constants.dart';

enum QRDataType {
  isScanned,
  isGenerated,
}

extension QRDataTypeEx on QRDataType {
  String get icon {
    switch (this) {
      case QRDataType.isGenerated:
        return AppAssets.instance.icGenerate;
      case QRDataType.isScanned:
        return AppAssets.instance.icScanner;
      default:
        throw 'Not found Icon for QRDataType';
    }
  }

  String get label {
    switch (this) {
      case QRDataType.isGenerated:
        return "Generated QR";
      case QRDataType.isScanned:
        return "Scanned QR";
      default:
        throw 'Not found Icon for QRDataType';
    }
  }
}
