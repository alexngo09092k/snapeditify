import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/theme.dart';
import 'package:snapeditify/generated/l10n.dart';
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
  Widget build(BuildContext context) {
    double scale = AwesomeAppState.screen.width < 300 ? 0.8 : (AwesomeAppState.screen.width < 365 ? 0.9 : 1);
    Debug.log("============= SCALE $scale =============");

    return Consumer<IThemeProvider>(
      builder: (_, __, provider) {
        Debug.log("===== START APP =====");
        Debug.log("===== THEME MODE: ${provider.themeMode} =====");
        final light = getLightTheme(context, scale: scale);
        final dark = getDarkTheme(context, scale: scale);
        return MaterialApp(
          title: Configuration.instance.business.appName,
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
