import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/generated/l10n.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';
import 'package:phosart/providers/remove_object/remove_object_provider.dart';

class RemoveObjectSave extends StatelessWidget {
  const RemoveObjectSave({super.key, required this.provider});
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (provider.canSave) {
          AppRoutes.instance.goSavePage(context, photosFor: EditImageType.removeObject);
        }
      },
      child: PropConsumer<RemoveObjectProvider, bool>(
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
