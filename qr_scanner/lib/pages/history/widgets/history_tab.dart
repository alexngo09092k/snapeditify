import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_source.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';
import 'package:qr_scanner/widgets/base/sliding_control.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({
    super.key,
    required this.tab,
    required this.onChanged,
  });
  final ValueNotifier<QRSource> tab;
  final Function(QRSource) onChanged;

  void _onChangedTab(QRSource? type) {
    if (type == null) return;
    onChanged(type);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: tab,
        builder: (_, __) => SlidingControl<QRSource>(
          value: tab.value,
          color: Theme.of(context).colorScheme.surface,
          background: Theme.of(context).disabledColor.withOpacity(0.1),
          children: QRSource.values.asMap().map(
                (_, e) => MapEntry(
                  e,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.instance.padding,
                      vertical: AppDimensions.instance.paddingX(0.5),
                    ),
                    child: Row(
                      children: [
                        CustomIcon(e.icon),
                        SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                        Text(e.label, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
          onValueChanged: _onChangedTab,
        ),
      ),
    );
  }
}
