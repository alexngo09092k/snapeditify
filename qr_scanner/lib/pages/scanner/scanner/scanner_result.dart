import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/providers/scanner_provider.dart';

class ScannerResult extends StatefulWidget {
  const ScannerResult({super.key});

  @override
  State<ScannerResult> createState() => _ScannerResultState();
}

class _ScannerResultState extends ProviderStateful<ScannerResult, ScannerProvider> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return AnimatedBuilder(
    //     animation: provider.barcodeCaptures,
    //     builder: (_, __) {
    //       if (provider.barcodeCaptures.value.isEmpty) return const SizedBox();
    //       return ClipRRect(
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(AppDimensions.instance.radius),
    //         ),
    //         child: SizedBox(
    //           width: 100,
    //           child: Stack(
    //             alignment: Alignment.center,
    //             children: [
    //               Image(image: MemoryImage(provider.barcodeCaptures.value.last.image!)),
    //               Text(
    //                 '+${provider.barcodeCaptures.value.length.toString()}',
    //                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     });
  }
}
