import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/configuration.dart';
import 'package:phosart/models/config/bussiness_config.dart';
import 'package:phosart/common/extensions.dart';
import 'package:phosart/widgets/base/app_layout.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends AwesomeSplashState<SplashPage> {
  bool _goToApp = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void onSplash(bool resultOnWillSplash) async {
    if (resultOnWillSplash && await ClientHttp.instance.safeEnvironment()) {
      _goTo();
    } else {}
  }

  _goTo() {
    if (!_goToApp) {
      _goToApp = true;
      _mode();
    }
  }

  _mode() {
    switch (Configuration.instance.businessConfig.appMode) {
      case AppMode.debug:
      case AppMode.production:
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.homePage, (_) => false);
        break;
      case AppMode.maintenance:
      default:
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.maintenancePage, (_) => false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      back: false,
      children: [
        AwesomeAnimation<double>.tweenSequence(
          duration: const Duration(milliseconds: 200),
          items: [
            TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 10),
          ],
          builder: (_, __, animation, ___) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Opacity(
                opacity: animation.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
