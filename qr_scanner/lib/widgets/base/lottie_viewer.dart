import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_scanner/common/configuration.dart';

class LottieViewer extends StatelessWidget {
  const LottieViewer({
    super.key,
    required this.lottie,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.repeat,
  });

  final String lottie;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final bool? repeat;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: Configuration.instance.isNetwork(lottie)
            ? Lottie.network(
                lottie,
                fit: BoxFit.cover,
                width: width,
                height: height,
                repeat: repeat,
                errorBuilder: _errorBuilder,
              )
            : Lottie.asset(
                lottie,
                fit: BoxFit.cover,
                width: width,
                height: height,
                repeat: repeat,
                errorBuilder: _errorBuilder,
              ),
      ),
    );
  }

  Widget _errorBuilder(BuildContext context, Object obj, StackTrace? stack) {
    return const SizedBox();
  }
}
