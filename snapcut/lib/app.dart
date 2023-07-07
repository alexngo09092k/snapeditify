import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../AppTheme.dart';
import 'pages/SplashScreen.dart';
import '../../store/AppStore.dart';
import '../../utils/Constants.dart';

AppStore appStore = AppStore();

bool bannerReady = false;
bool interstitialReady = false;
bool isRewardedAdReady = false;
bool rewarded = false;

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: mAppName,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
      scrollBehavior: MyBehavior(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
