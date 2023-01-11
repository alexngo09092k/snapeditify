import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/theme.dart';
import 'package:phosart/generated/l10n.dart';
import 'package:fluttering/fluttering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:phosart/widgets/base/loading.dart';
import 'package:phosart/widgets/base/toast.dart';

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
    double scale = AwesomeAppState.screen.width < 270 ? 0.65 : (AwesomeAppState.screen.width < 361 ? 0.85 : 1);
    Debug.log("============= SCALE $scale =============");

    return Consumer<IThemeProvider>(
      builder: (_, __, ___) {
        Debug.log("===== START APP =====");
        Debug.log("===== THEME MODE: ${provider.themeMode} =====");
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AwesomeAppState.navigatorKey,
          theme: getLightTheme(context, scale: scale),
          darkTheme: getDarkTheme(context, scale: scale),
          themeMode: provider.themeMode,
          initialRoute: AppRoutes.instance.initialRoute,
          onGenerateRoute: AppRoutes.instance.onGenerateRoute,
          navigatorObservers: [AwesomeApp.observer, FlutterSmartDialog.observer],
          routes: AppRoutes.instance.routes,
          // locale: _appProvider.currentLocale,
          localeResolutionCallback: provider.onChangeLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: FlutterSmartDialog.init(
            toastBuilder: (String msg) => Toast(message: msg),
            loadingBuilder: (String msg) => Loading(message: msg),
          ),
        );
      },
    );
  }
}
