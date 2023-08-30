import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class SaveButton<T extends EditImageProvider> extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PropConsumer<T, bool>(
      select: (p) => p.canSave,
      builder: (_, __, p, ___) => GestureDetector(
        onTap: () => p.saveImage(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
          child: CustomIcon(
            CupertinoIcons.share,
            color: p.canSave
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
          ),
        ),
      ),
    );
  }
}
