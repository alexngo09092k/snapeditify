import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieView extends StatefulWidget {
  final String imageUrl;
  final int duration;
  final Function? onSuccess;
  final double? width;
  final double? height;
  const LottieView({
    required this.imageUrl,
    this.height,
    this.width,
    this.duration = 1000,
    this.onSuccess,
  });

  @override
  _StateLottieView createState() => _StateLottieView();
}

class _StateLottieView extends State<LottieView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: widget.duration), () {
        widget.onSuccess?.call();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.imageUrl.startsWith('http')
          ? Lottie.network(
              widget.imageUrl,
              fit:BoxFit.fill,
              height: widget.height,
              width: widget.width,
              errorBuilder: (_, __, ___) {
                return const SizedBox();
              },
            )
          : Lottie.asset(
              widget.imageUrl,
              height: widget.height,
              width: widget.width,
              fit:BoxFit.fill,
              errorBuilder: (_, __, ___) {
                return const SizedBox();
              },
            ),
    );
  }
}
