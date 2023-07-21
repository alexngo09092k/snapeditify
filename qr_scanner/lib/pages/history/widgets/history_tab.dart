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
    return Padding(
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: AnimatedBuilder(
        animation: tab,
        builder: (_, __) => SizedBox(
          width: double.infinity,
          child: SlidingControl<QRSource>(
            value: tab.value,
            color: Theme.of(context).colorScheme.primary,
            background: Theme.of(context).cardColor,
            children: QRSource.values.asMap().map(
                  (_, e) => MapEntry(
                    e,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.instance.padding,
                        vertical: AppDimensions.instance.paddingX(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIcon(e.icon,
                              color: e == tab.value
                                  ? AppColors.instance.white
                                  : null),
                          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                          Text(
                            e.label,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: e == tab.value
                                        ? AppColors.instance.white
                                        : null),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            onValueChanged: _onChangedTab,
          ),
        ),
      ),
    );
  }
}
