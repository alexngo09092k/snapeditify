
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snapedit/generated/l10n.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  ThemeMode themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Cofiguration.appName,
      // home: const FlutterPainterExample(),
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      theme: themeMode == ThemeMode.light
          ? getLightTheme(context)
          : getDarkTheme(context),
      themeMode: themeMode,
      initialRoute: AppRoutes.initialRoute,
      // routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode || supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.firstWhere((supportedLocale) => supportedLocale.languageCode == 'en');
      },
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
