import 'package:flutter/material.dart';
import 'package:snapedit/pages/restyle/widgets/restyle_image.dart';
import 'package:snapedit/widgets/app_layout.dart';

class RestylePage extends StatelessWidget {
  const RestylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      back: true,
      scroll: false,
      screen: 'Art effect',
      children: [
        RestyleImage(),
      ],
    );
  }
}
