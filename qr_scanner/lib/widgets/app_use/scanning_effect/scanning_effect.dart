// Thank you to the author of the original post that this widget was build base on it.
// https://medium.com/@webianks/scanning-animation-in-flutter-99fb26aabbb7

import 'package:flutter/material.dart';
import 'package:qr_scanner/widgets/app_use/scanning_effect/scanner_animation.dart';
import 'package:qr_scanner/widgets/app_use/scanning_effect/scanner_border_painter.dart';

/// The [ScanningEffect] is the view where scanner animation
/// and scanning border line display.
class ScanningEffect extends StatefulWidget {
  const ScanningEffect({
    super.key,
    this.child,
    this.scanningColor = Colors.lightBlue,
    this.delay = const Duration(milliseconds: 700),
    this.duration = const Duration(milliseconds: 2800),
    this.borderLineWidth = 2,
    this.borderLineColor = Colors.lightBlue,
    this.overlay = true,
    required this.scanWindow,
  });

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// The color of the scanning animation
  final Color scanningColor;

  /// The color of the border line
  final Color borderLineColor;

  /// The delay between each animation
  final Duration delay;

  /// The length of time this animation should last.
  final Duration duration;

  final Rect scanWindow;

  final double borderLineWidth;

  final bool overlay;

  @override
  State<ScanningEffect> createState() => _ScanningEffectState();
}

class _ScanningEffectState extends State<ScanningEffect> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(
            widget.delay,
            () {
              _animationController
                ..reset()
                ..forward(from: 0);
            },
          );
        }
      })
      ..forward(from: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child ?? const SizedBox(),
        if (widget.overlay)
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcOut,
            ), // This one will create the magic
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    backgroundBlendMode: BlendMode.dstOut,
                  ), // This one will handle background + difference out
                ),
                Positioned(
                  top: widget.scanWindow.top + widget.borderLineWidth,
                  left: widget.scanWindow.left + widget.borderLineWidth,
                  child: Container(
                    height: widget.scanWindow.height - widget.borderLineWidth * 2,
                    width: widget.scanWindow.width - widget.borderLineWidth * 2,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        Positioned(
          top: widget.scanWindow.top,
          left: widget.scanWindow.left,
          child: CustomPaint(
            painter: ScannerBorderPainter(
              color: widget.borderLineColor,
              width: widget.borderLineWidth,
            ),
            child: Container(
              width: widget.scanWindow.width,
              height: widget.scanWindow.height,
              padding: EdgeInsets.all(widget.borderLineWidth),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20 + widget.borderLineWidth),
                ),
                child: ScannerAnimation(
                  animation: _animationController,
                  scanningColor: widget.scanningColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
