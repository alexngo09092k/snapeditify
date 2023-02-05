import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingControl<T> extends StatelessWidget {
  const SlidingControl({
    super.key,
    required this.value,
    required this.children,
    required this.color,
    required this.background,
    required this.onValueChanged,
  });
  final T value;
  final Map<T, Widget> children;
  final Color color;
  final Color background;
  final void Function(T?) onValueChanged;

  factory SlidingControl.defaultStyle(
    BuildContext context, {
    required T value,
    required Map<T, String> data,
    required void Function(T?) onValueChanged,
  }) {
    return SlidingControl<T>(
      value: value,
      children: data.map(
        (key, item) => MapEntry(
          key,
          Text(
            item,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
      color: Theme.of(context).cardColor,
      background: Theme.of(context).disabledColor.withOpacity(0.1),
      onValueChanged: onValueChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<T>(
      thumbColor: color,
      backgroundColor: background,
      // This represents the currently selected segmented control.
      groupValue: value,
      // Callback that sets the selected segmented control.
      onValueChanged: onValueChanged,
      children: children,
    );
  }
}
