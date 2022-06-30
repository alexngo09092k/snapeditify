import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/services/advertisement/app_lifecycle/app_lifecycle_handler.dart';

class AppLifecycleReactor {
  AppLifecycleReactor({required this.handler});

  AppLifeCycleHandler handler;

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    switch (appState) {
      case AppState.foreground:
        printLog('foreground');
        handler.onForeground();
        break;
      case AppState.background:
        printLog('background');
        handler.onBackground();
        break;
      default:
    }
  }
}
