// ignore_for_file: constant_identifier_names

enum QRFormat {
  /// ITF16 Barcode
  CodeITF16,

  /// ITF14 Barcode
  CodeITF14,

  /// EAN 13 barcode
  CodeEAN13,

  /// EAN 8 barcode
  CodeEAN8,

  /// EAN 5 barcode
  CodeEAN5,

  /// EAN 2 barcode
  CodeEAN2,

  /// ISBN barcode
  CodeISBN,

  /// Code 39 barcode
  Code39,

  /// Code 93 barcode
  Code93,

  /// UPC-A barcode
  CodeUPCA,

  /// UPC-E barcode
  CodeUPCE,

  /// Code 128 barcode
  Code128,

  /// GS1-128 barcode
  GS128,

  /// Telepen Barcode
  Telepen,

  /// QR Code
  QrCode,

  /// Codabar
  Codabar,

  /// Pdf417
  PDF417,

  /// Datamatrix
  DataMatrix,

  /// Aztec
  Aztec,

  /// RM4SCC
  Rm4scc,

  /// Interleaved 2 of 5 (ITF)
  Itf,
}

extension QRFormatEx on QRFormat {
  String get label {
    switch (this) {
      case QRFormat.Aztec:
        return "Aztec Code";
      case QRFormat.Codabar:
        return "Codabar Code";
      case QRFormat.Code128:
        return "Code 128";
      case QRFormat.Code39:
        return "Code 39";
      case QRFormat.Code93:
        return "Code 93";
      case QRFormat.CodeEAN13:
        return "EAN-13 Code";
      case QRFormat.CodeEAN2:
        return "EAN-2 Code";
      case QRFormat.CodeEAN5:
        return "EAN-5 Code";
      case QRFormat.CodeEAN8:
        return "EAN-8 Code";
      case QRFormat.CodeISBN:
        return "ISBN Code";
      case QRFormat.CodeITF14:
        return "ITF-14 Code";
      case QRFormat.CodeITF16:
        return "ITF-16 Code";
      case QRFormat.CodeUPCA:
        return "UPCA Code";
      case QRFormat.CodeUPCE:
        return "UPCE Code";
      case QRFormat.DataMatrix:
        return "Data Matrix Code";
      case QRFormat.GS128:
        return "GS-128 Code";
      case QRFormat.Itf:
        return "ITF Code";
      case QRFormat.PDF417:
        return "PDF-417 Code";
      case QRFormat.QrCode:
        return "QR Code";
      case QRFormat.Rm4scc:
        return "RM4SCC Code";
      case QRFormat.Telepen:
        return "Telepen Code";
      default:
        return "QR Code";
    }
  }
}
