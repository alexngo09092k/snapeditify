import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/theme.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:fluttering/fluttering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snapeditify/utils/widget.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends AwesomeAppState<App> {

  @override
  void initState() {
    super.initState();
    WidgetUtils.instance.checkAppUpdate();
  }

  @override
  Widget build(BuildContext context) {
    double scale = AwesomeAppState.screen.width < 300 ? 0.8 : (AwesomeAppState.screen.width < 365 ? 0.9 : 1);
    Debug.log("============= SCALE $scale =============");

    return Consumer<IThemeProvider>(
      builder: (_, __, provider) {
        Debug.log("===== START APP =====");
        Debug.log("===== THEME MODE: ${provider.themeMode} =====");
        Debug.log("===== LOCALE: ${provider.locale} =====");
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
          locale: provider.locale,
          // localeResolutionCallback: provider.onChangeLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
