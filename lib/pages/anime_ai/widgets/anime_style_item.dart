// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/anime_ai/anime_ai_provider.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_styles_response.dart';

class AnimeStyleItem extends StatelessWidget {
  const AnimeStyleItem({super.key, required this.provider, required this.style, required this.onStyle});
  final AnimeAIProvider provider;
  final AnimeStyle style;
  final Function(AnimeStyle) onStyle;

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
            BasePropConsumer<AnimeAIProvider, String?>(
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
