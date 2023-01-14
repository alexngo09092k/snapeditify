import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';

class SavedImagePreview extends StatelessWidget {
  const SavedImagePreview({super.key, required this.file});
  final File file;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Image.file(
          file,
          fit: BoxFit.cover,
          width: AwesomeAppState.screen.width,
        ),
      ),
    );
  }
}
