import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/sliding_control.dart';

class RestoreControl extends StatefulWidget {
  const RestoreControl({
    super.key,
  });

  @override
  State<RestoreControl> createState() => _RestoreControlState();
}

class _RestoreControlState extends State<RestoreControl> {
  final ValueNotifier<int> tab = ValueNotifier(0);

  void _onChangedTab(int? type) {
    if (type == null) return;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: tab,
      builder: (_, value, __) => SizedBox(
        width: double.infinity,
        child: SlidingControl<int>(
          value: value,
          color: Theme.of(context).colorScheme.primary,
          background: Theme.of(context).cardColor,
          children: {
            0: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.instance.padding,
                vertical: AppDimensions.instance.paddingX(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Oki",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: value == 0 ? AppColors.instance.white : null,
                        ),
                  ),
                ],
              ),
            ),
            1: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.instance.padding,
                vertical: AppDimensions.instance.paddingX(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Oki",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: value == 0 ? AppColors.instance.white : null,
                        ),
                  ),
                ],
              ),
            ),
          },
          onValueChanged: _onChangedTab,
        ),
      ),
    );
  }
}
