import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/scanner/scanner/scanner.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      child: Scanner(),
    );
  }
}
