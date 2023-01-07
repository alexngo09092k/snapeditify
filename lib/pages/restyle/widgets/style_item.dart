// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
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
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
              child: Container(
                child: Image.network(
                  style.thumbnailUrl,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            SizedBox(height: AppDimensions.instance.paddingX(0.5)),
            BasePropConsumer<RestyleProvider, String?>(
              listenable: provider,
              select: (_) => _.state.styleId,
              builder: (_, __, p, ___) => Text(
                style.name,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: p.state.styleId == style.styleId ? AppColors.instance.blue600 : null,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
