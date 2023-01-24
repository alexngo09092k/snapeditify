import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/providers/remove_object/remove_object_provider.dart';
import 'package:phosart/utils/widget.dart';
import 'package:phosart/widgets/base/custom_icon.dart';

class RemoveObjectRevert extends StatelessWidget {
  const RemoveObjectRevert({super.key, required this.provider});
  final RemoveObjectProvider provider;

  _revert(BuildContext context) {
    WidgetUtils.instance.alert(context, title: 'Revert', message: 'Are you sure revert all changed', actions: []);
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
