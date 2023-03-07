// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';

class BaseImageEditor extends StatelessWidget {
  const BaseImageEditor({
    Key? key,
    required this.builder,
    this.width,
    this.height,
  }) : super(key: key);

  final Widget Function(double width, double height) builder;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PropConsumer<IThemeProvider, ThemeMode>(
          select: (_) => _.themeMode,
          builder: (_, __, p, ___) {
            return LayoutBuilder(
              builder: (_, __) => Container(
                color: p.themeMode == ThemeMode.dark
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                child: builder(__.maxWidth, __.maxHeight),
              ),
            );
          }),
    );
  }
}
