import 'package:flutter/material.dart';

class CustomAnimation<T> extends StatefulWidget {
  CustomAnimation({
    Key? key,
    this.child,
    this.builder,
    this.onEnd,
    required this.setAnimation,
    this.after,
    this.duration = const Duration(milliseconds: 2000),
  }) : super(key: key);
  final Duration duration;
  Function? onEnd;
  Animation<T> Function(AnimationController) setAnimation;
  final Duration? after;
  Widget Function(BuildContext, Widget, Animation<T>, AnimationController)? builder;
  final Widget? child;
  @override
  State<CustomAnimation<T>> createState() => _CustomAnimationState<T>();
}

class _CustomAnimationState<T> extends State<CustomAnimation<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<T> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = widget.setAnimation(_controller);

    super.initState();

    if (widget.after != null) {
      Future.delayed(widget.after!, () {
        _controller.forward();
      });
    } else {
      _controller.forward();
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.onEnd != null) {
          widget.onEnd!();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_context, _child) =>
          widget.builder!(_context, _child ?? const SizedBox(), _animation, _controller),
      child: widget.child,
    );
  }
}
