import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snapretouch/common/app_cache.dart';
import 'package:snapretouch/common/app_internet.dart';
import 'package:snapretouch/common/app_routes.dart';
import 'package:snapretouch/common/app_shared.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/common/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/services/services.dart';
import 'package:snapretouch/widgets/custom_overlay_state.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends CustomOverlayState<App>{
  @override
  void initState() {
    super.initState();
    Cofiguration.instance.addListener((event) {
      if (event == CofigurationEvent.loadRemoteConfigSuccessed) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    AppCache.instance.clean();
    AppInternet.instance.dispose();
    AppShared.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Cofiguration.appConfig.name,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      theme: getLightTheme(context),
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      navigatorObservers: [
        AppRouteObserver(
          action: (screenName) =>
              OverlayControlDelegate().emitRoute?.call(screenName),
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

  @override
  void onBackground() {
    Services().advertisement.onBackground();
  }

  @override
  void onForeground() {
    Services().advertisement.onForeground();
  }
}
