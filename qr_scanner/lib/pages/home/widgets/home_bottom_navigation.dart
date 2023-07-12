import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/home_navigation.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({
    super.key,
    required this.navigation,
    required this.onChange,
  });
  final HomeNavigation navigation;
  final Function(HomeNavigation) onChange;

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
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.instance.paddingX(0.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIcon(e.icon),
                        SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                        Text(
                          e.label,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
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
