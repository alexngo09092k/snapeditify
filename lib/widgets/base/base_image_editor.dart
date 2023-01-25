// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';

class BaseImageEditor extends StatelessWidget {
  const BaseImageEditor({
    Key? key,
    required this.builder,
    this.width,
    this.height,
    this.background,
  }) : super(key: key);

  final Widget Function(double width, double height) builder;
  final double? width;
  final double? height;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (_, __) => Container(
          color: background ?? AppColors.instance.darkLiver.withOpacity(0.1),
          child: builder(__.maxWidth, __.maxHeight),
        ),
      ),
    );
  }
}
