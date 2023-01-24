import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/theme.dart';
import 'package:phosart/generated/l10n.dart';
import 'package:fluttering/fluttering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends AwesomeAppState<App> {
  @override
  void initState() {
    super.initState();
    provider.onChangePlatformBrightness();
  }

  @override
  void didChangePlatformBrightness() {
    provider.onChangePlatformBrightness();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    double scale = AwesomeAppState.screen.width < 250 ? 0.65 : (AwesomeAppState.screen.width < 340 ? 0.85 : 1);
    Debug.log("============= SCALE $scale =============");

    return Consumer<IThemeProvider>(
      builder: (_, __, ___) {
        Debug.log("===== START APP =====");
        Debug.log("===== THEME MODE: ${provider.themeMode} =====");
        final light = getLightTheme(context, scale: scale);
        final dark = getDarkTheme(context, scale: scale);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AwesomeAppState.navigatorKey,
          theme: light,
          darkTheme: dark,
          themeMode: provider.themeMode,
          initialRoute: AppRoutes.instance.initialRoute,
          onGenerateRoute: AppRoutes.instance.onGenerateRoute,
          navigatorObservers: [AwesomeApp.observer],
          routes: AppRoutes.instance.routes,
          localeResolutionCallback: provider.onChangeLocale,
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
