import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/pages/home/widgets/home_options_modal.dart';
import 'package:snapedit/widgets/base/custom_icon.dart';
import 'package:snapedit/widgets/widget.utils.dart';

class HomeFloatButton extends StatefulWidget {
  const HomeFloatButton({super.key});

  @override
  State<HomeFloatButton> createState() => _HomeFloatButtonState();
}

class _HomeFloatButtonState extends State<HomeFloatButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _anim = TweenSequence<double>([TweenSequenceItem(tween: Tween(begin: 0, end: pi / 6), weight: 1)]).animate(_controller);
    super.initState();
  }

  void _onTap() {
    if (_controller.isDismissed) {
      _controller.forward();
      showModalBottom(context, const HomeOptionsModal()).whenComplete(_controller.reverse);
    } else {
      _controller.reverse();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: AppDimensions.instance.iconX(2),
        height: AppDimensions.instance.iconX(2),
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        child: AnimatedBuilder(
          animation: _anim,
          child: CustomIcon(
            AppAssets.instance.icAdd,
            color: Colors.white,
            radius: 50,
            background: Colors.red,
            size: AppDimensions.instance.iconX(2),
            spacing: AppDimensions.instance.icon,
          ),
          builder: (_, __) => Transform.rotate(
            angle: _anim.value,
            child: __,
          ),
        ),
      ),
    );
  }
}
