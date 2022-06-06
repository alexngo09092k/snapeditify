import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snapretouch/common/app_routes.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/common/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/widgets/custom_overlay_state.dart';

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
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      theme: themeMode == ThemeMode.light
          ? getLightTheme(context)
          : getDarkTheme(context),
      themeMode: themeMode,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      navigatorObservers: [
        AppRouteObserver(
          action: (screenName) => OverlayControlDelegate().emitRoute?.call(screenName),
        ),
      ],
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.firstWhere(
            (supportedLocale) => supportedLocale.languageCode == 'en');
      },
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
