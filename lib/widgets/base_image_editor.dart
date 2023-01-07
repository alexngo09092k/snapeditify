import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';

class BaseImageEditor extends StatelessWidget {
  const BaseImageEditor({Key? key, required this.builder}) : super(key: key);
  final Widget Function(double width, double height) builder;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 2 / 3;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.instance.blue100,
      width: width,
      height: height,
      child: builder(width, height),
    );
  }
}
