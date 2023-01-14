import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/widgets/base/app_layout.dart';

class SavedImagePreview extends StatelessWidget {
  const SavedImagePreview({super.key, required this.file});
  final File file;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      back: true,
      children: [
        Center(
          child: Image.file(
            file,
            fit: BoxFit.cover,
            width: AwesomeAppState.screen.width,
          ),
        )
      ],
    );
  }
}
