import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/generated/l10n.dart';
import 'package:phosart/providers/edit_image_provider.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.provider});
  final EditImageProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => provider.saveImage(context),
      child: PropConsumer<EditImageProvider, bool>(
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
