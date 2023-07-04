import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/remover/remover_provider.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/base/custom_alert.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class RemoveObjectRevert extends ProviderStateless<IRemoverProvider> {
  RemoveObjectRevert({super.key});
  _revert(BuildContext context) {
    WidgetUtils.instance.alert(
      context,
      title: S.of(context).discardChangesAndRevert,
      message: S.of(context).allChangesWillBeLostYourImageWillBeReverted,
      actions: [
        AlertAction(
          title: S.of(context).cancel,
          onPressed: Navigator.of(context).pop,
        ),
        AlertAction(
          title: S.of(context).ok,
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(context).pop();
            provider.revert();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PropConsumer<IRemoverProvider, bool>(
      select: (p) => p.canRevert,
      builder: (_, __, ___, canRevert) => GestureDetector(
        onTap: canRevert ? () => _revert(context) : null,
        child: CustomIcon(
          CupertinoIcons.arrow_counterclockwise,
          color: canRevert ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}
