import 'package:flutter/material.dart';
import 'package:snapedit/providers/restyle/restyle_provider.dart';
import 'package:snapedit/services/snap_edit/src/models/response/styles_response.dart';

class StyleItem extends StatelessWidget {
  const StyleItem({super.key, required this.provider, required this.style, required this.onStyle});
  final RestyleProvider provider;
  final Style style;
  final Function(Style) onStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onStyle(style),
      child: SizedBox(
        width: 150,
        height: 150,
        child: Stack(
          children: [
            Image.network(style.thumbnailUrl),
            Text(style.name),
          ],
        ),
      ),
    );
  }
}
