import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/pages/scanner/scanner/scanner_result.dart';
import 'package:qr_scanner/pages/scanner/scanner/scanner_settings.dart';
import 'package:qr_scanner/providers/scanner_provider.dart';
import 'package:qr_scanner/widgets/app_use/scanning_effect/scanning_effect.dart';

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    final double size = AwesomeAppState.screen.width * 2.3 / 3;
    final Offset center = Offset(
        AwesomeAppState.screen.width / 2, AwesomeAppState.screen.height / 2.6);
    final scanWindow =
        Rect.fromCenter(center: center, width: size, height: size);
    return Stack(
      alignment: Alignment.center,
      children: [
        PropConsumer<ScannerProvider, MobileScannerController>(
          select: (_) => _.controller,
          builder: (_, __, provider, controller) => MobileScanner(
            scanWindow: scanWindow,
            controller: controller,
            onDetect: provider.onDetect,
            onScannerStarted: provider.onStarted,
          ),
        ),
        ScanningEffect(
          scanWindow: scanWindow,
          scanningColor: Theme.of(context).colorScheme.primary,
          borderLineColor: Theme.of(context).colorScheme.primary,
        ),
        Positioned(
          top: AppDimensions.instance.padding,
          right: AppDimensions.instance.padding,
          child: const ScannerResult(),
        ),
        Positioned(
          top: center.dy + size / 2 + AppDimensions.instance.paddingX(2),
          child: ScannerSettings(width: size),
        ),
      ],
    );
  }
}
