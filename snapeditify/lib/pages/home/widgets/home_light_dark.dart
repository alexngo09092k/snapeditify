import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';


class HomeLightDarkButton extends StatelessWidget {
  const HomeLightDarkButton({super.key});

  _changeMode() {
    final p = ManagerProvider.of<IThemeProvider>();
    p.changeThemeMode(
      p.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PropConsumer<IThemeProvider, ThemeMode>(
      select: (_) => _.themeMode,
      builder: (_, __, p, ___) => GestureDetector(
        onTap: _changeMode,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.5)),
          child: CustomIcon(
            p.themeMode == ThemeMode.light ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
          ),
        ),
      ),
    );
  }
}

