import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/theme.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:fluttering/fluttering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends AwesomeAppState<App> {
  late IThemeProvider _themeProvider;

  @override
  void initState() {
    /// lock android phone in portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _themeProvider = ManagerProvider.of<IThemeProvider>();
    _themeProvider.onChangePlatformBrightness();

    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    _themeProvider.onChangePlatformBrightness();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    double scale = AwesomeAppState.screen.width < 270 ? 0.65 : (AwesomeAppState.screen.width < 361 ? 0.85 : 1);
    Debug.log("============= SCALE $scale =============");

    return Consumer<IThemeProvider>(
      builder: (_, __, ___) {
        Debug.log("===== START APP =====");
        Debug.log("===== THEME MODE: ${_themeProvider.themeMode} =====");
        return MaterialApp(
          navigatorKey: AwesomeAppState.navigatorKey,
          theme: getLightTheme(context, scale: scale),
          darkTheme: getDarkTheme(context, scale: scale),
          themeMode: _themeProvider.themeMode,
          initialRoute: AppRoutes.initialRoute,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          navigatorObservers: [AppRouteObserver(action: (name) => Debug.log("==== SCREEN $name ===="))],
          routes: AppRoutes.routes,
          // locale: _appProvider.currentLocale,
          localeResolutionCallback: _themeProvider.onChangeLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
