import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/generated/l10n.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';
import 'package:phosart/providers/restyle/restyle_provider.dart';

class RestyleSave extends StatelessWidget {
  const RestyleSave({super.key, required this.provider});
  final RestyleProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (provider.canSave) {
          AppRoutes.instance.goSavePage(context, photosFor: EditImageType.applyArtEffect);
        }
      },
      child: BasePropConsumer<RestyleProvider, bool>(
        listenable: provider,
        select: (p) => p.canSave,
        builder: (_, __, p, ___) => Container(
          padding: EdgeInsets.all(AppDimensions.instance.padding),
          child: Text(
            S.of(context).save,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: p.canSave ? Theme.of(context).colorScheme.primary : null),
          ),
        ),
      ),
    );
  }
}
