import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/home_navigation.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({
    super.key,
    required this.navigation,
    required this.onChange,
    required this.current,
  });
  final HomeNavigation navigation;
  final Function(HomeNavigation) onChange;
  final HomeNavigation current;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(AppDimensions.instance.radius),
        topLeft: Radius.circular(AppDimensions.instance.radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: HomeNavigation.values
            .map(
              (e) => Expanded(
                child: GestureDetector(
                  onTap: () => onChange(e),
                  child: Container(
                    color: Theme.of(context).cardColor,
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.instance.paddingX(0.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIcon(
                          e.icon,
                          color: current == e
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                        Text(
                          e.label,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: current == e
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
