// ignore_for_file: constant_identifier_names

import 'package:barcode_widget/barcode_widget.dart';

enum QRFormat {
  /// QR Code
  QrCode,

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

  Barcode get barcode {
    switch (this) {
      case QRFormat.CodeUPCA:
        return Barcode.upcA();
      case QRFormat.CodeUPCE:
        return Barcode.upcE();
      case QRFormat.Code128:
        return Barcode.code128();
      case QRFormat.Code39:
        return Barcode.code39();
      case QRFormat.Code93:
        return Barcode.code93();
      case QRFormat.CodeEAN13:
        return Barcode.ean13();
      case QRFormat.CodeEAN2:
        return Barcode.ean2();
      case QRFormat.CodeEAN5:
        return Barcode.ean5();
      case QRFormat.CodeEAN8:
        return Barcode.ean8();
      case QRFormat.Codabar:
        return Barcode.codabar();
      case QRFormat.Aztec:
        return Barcode.aztec();
      case QRFormat.CodeITF14:
        return Barcode.itf14();
      case QRFormat.CodeITF16:
        return Barcode.itf16();
      case QRFormat.DataMatrix:
        return Barcode.dataMatrix();
      case QRFormat.Itf:
        return Barcode.itf();
      case QRFormat.PDF417:
        return Barcode.pdf417();
      case QRFormat.GS128:
        return Barcode.gs128();
      case QRFormat.Rm4scc:
        return Barcode.rm4scc();
      case QRFormat.Telepen:
        return Barcode.telepen();
      default:
        return Barcode.qrCode();
    }
  }
}
