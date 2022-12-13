import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingControl<T> extends StatefulWidget {
  const SlidingControl({
    super.key,
    required this.value,
    required this.children,
    required this.color,
    required this.onValueChanged,
  });
  final T value;
  final Map<T, Widget> children;
  final Color color;
  final void Function(T) onValueChanged;

  factory SlidingControl.defaultStyle(
    BuildContext context, {
    required T value,
    required Map<T, String> data,
    required void Function(T) onValueChanged,
  }) {
    return SlidingControl<T>(
      value: value,
      children: data.map(
        (key, value) => MapEntry(
          key,
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      color: Theme.of(context).cardColor,
      onValueChanged: onValueChanged,
    );
  }

  @override
  State<SlidingControl> createState() => _SlidingControlState();
}

class _SlidingControlState<T> extends State<SlidingControl<T>> {
  late T _selectedSegment;

  @override
  void initState() {
    _selectedSegment = widget.value;
    super.initState();
  }

  _onValueChanged(T? value) {
    if (value != null) {
      _selectedSegment = value;
      widget.onValueChanged(value);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<T>(
      thumbColor: widget.color,
      backgroundColor: CupertinoColors.systemGrey2,
      // This represents the currently selected segmented control.
      groupValue: _selectedSegment,
      // Callback that sets the selected segmented control.
      onValueChanged: _onValueChanged,
      children: widget.children,
    );
  }
}
