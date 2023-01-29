import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/theme.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:fluttering/fluttering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snapeditify/services/services.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends AwesomeAppState<App> {
  late final IThemeProvider _provider;

  @override
  void initState() {
    _provider = ManagerProvider.of<ThemeProvider>();
    _provider.onChangePlatformBrightness();

    Services.instance.inAppReview.monitor(config: Configuration.instance.inAppReview);

    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    _provider.onChangePlatformBrightness();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    double scale = AwesomeAppState.screen.width < 300 ? 0.8 : (AwesomeAppState.screen.width < 365 ? 0.9 : 1);
    Debug.log("============= SCALE $scale =============");

    return Consumer<IThemeProvider>(
      builder: (_, __, ___) {
        Debug.log("===== START APP =====");
        Debug.log("===== THEME MODE: ${_provider.themeMode} =====");
        final light = getLightTheme(context, scale: scale);
        final dark = getDarkTheme(context, scale: scale);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AwesomeAppState.navigatorKey,
          theme: light,
          darkTheme: dark,
          themeMode: _provider.themeMode,
          initialRoute: AppRoutes.instance.initialRoute,
          onGenerateRoute: AppRoutes.instance.onGenerateRoute,
          navigatorObservers: [AwesomeApp.observer],
          routes: AppRoutes.instance.routes,
          localeResolutionCallback: _provider.onChangeLocale,
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
