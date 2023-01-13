import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/generated/l10n.dart';
import 'package:phosart/providers/anime_ai/anime_ai_provider.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';

class AnimeAISave extends StatelessWidget {
  const AnimeAISave({super.key, required this.provider});
  final AnimeAIProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (provider.canSave) {
          AppRoutes.instance.goSavePage(context, editImageType: EditImageType.animeAI);
        }
      },
      child: PropConsumer<AnimeAIProvider, bool>(
        select: (p) => p.canSave,
        builder: (_, __, p, ___) => Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
          child: Text(
            S.of(context).save,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: p.canSave ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                ),
          ),
        ),
      ),
    );
  }
}
