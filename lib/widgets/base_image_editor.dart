// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';

class BaseImageEditor extends StatelessWidget {
  const BaseImageEditor({Key? key, required this.builder, this.width, this.height}) : super(key: key);
  final Widget Function(double width, double height) builder;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final double _width = width ?? MediaQuery.of(context).size.width;
    final double _height = height ?? MediaQuery.of(context).size.height * 2 / 3;
    return Container(
      color: AppColors.instance.blue100,
      width: _width,
      height: _height,
      child: builder(_width, _height),
    );
  }
}
