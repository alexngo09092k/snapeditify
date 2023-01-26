import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/base/custom_alert.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class RemoveObjectRevert extends StatelessWidget {
  const RemoveObjectRevert({super.key, required this.provider});
  final RemoveObjectProvider provider;

  _revert(BuildContext context) {
    WidgetUtils.instance.alert(
      context,
      title: 'Discard changes and revert?',
      message: 'All changes will be lost. Your image will be reverted to its original states.',
      actions: [
        AlertAction(
          title: 'Cancel',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        AlertAction(
          title: 'Ok',
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
            provider.revert();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePropConsumer<RemoveObjectProvider, bool>(
      listenable: provider,
      select: (p) => p.canRevert,
      builder: (_, __, p, ___) => GestureDetector(
        onTap: p.canRevert ? () => _revert(context) : null,
        child: CustomIcon(
          CupertinoIcons.arrow_counterclockwise,
          color: p.canRevert ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}
