import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.backgroundColor,
    required this.radius,
  });

  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? backgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: List.generate(
        count,
        (index) {
          return CircleAvatar(
            radius: radius,
            backgroundColor:
                currentIndex == index ? activeColor : backgroundColor,
          );
        },
      ),
    );
  }
}
