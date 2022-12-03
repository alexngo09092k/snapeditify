import 'package:flutter/material.dart';
// import 'package:snapedit/common/constants.dart';

class SeparatedListView extends StatelessWidget {
  const SeparatedListView({super.key, required this.itemBuilder, required this.separatorBuilder, required this.itemCount});

  final Widget Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int) separatorBuilder;
  final int itemCount;

  factory SeparatedListView.withList({List<Widget> list = const [], Widget? separator}) {
    return SeparatedListView(
      itemBuilder: (_, i) => list[i],
      separatorBuilder: (_, __) => separator ?? const Divider(height: 0),
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    List<Widget> _ = List.generate(itemCount, (index) {
      if (index > 0 && index < itemCount) {
        children.add(separatorBuilder(context, index));
      }
      Widget _ = itemBuilder(context, index);
      children.add(_);
      return _;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
