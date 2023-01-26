import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/models/config/bussiness_config.dart';
import 'package:snapeditify/common/extensions.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends AwesomeSplashState<SplashPage> {
  bool _goToApp = false;
  final time = 2000;

  @override
  void initState() {
    super.initState();
  }

  @override
  void onSplash(bool resultOnWillSplash) async {
    final start = DateTime.now().millisecondsSinceEpoch;
    if (resultOnWillSplash && await ClientHttp.instance.safeEnvironment()) {
      final end = DateTime.now().millisecondsSinceEpoch;
      if ((end - start) >= time) {
        _goTo();
      } else {
        Future.delayed(Duration(milliseconds: (time - ((end - start)))), _goTo);
      }
    } else {
      WidgetUtils.instance.showErrorPopup(
        context,
        title: 'Internet connection',
        message: 'You are no longer connected to the internet',
        retry: (_) => AwesomeApp.instance?.restart(),
      );
    }
  }

  _goTo() {
    if (!_goToApp) {
      _goToApp = true;
      _mode();
    }
  }

  _mode() {
    switch (Configuration.instance.business.appMode) {
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
    final logoWidth = AwesomeAppState.screen.width * 1 / 3;
    return Scaffold(
      body: Center(
        child: AwesomeAnimation<double>.tweenSequence(
          duration: Duration(milliseconds: time - 200),
          items: [
            TweenSequenceItem(tween: Tween<double>(begin: 0, end: 0.2), weight: 1),
            TweenSequenceItem(tween: Tween<double>(begin: 0.8, end: 1), weight: 1),
          ],
          builder: (_, __, animation, ___) => Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: Offset(logoWidth * (animation.value > 0.5 ? (0.3 - animation.value) : 0), 0),
                child: CustomImage(
                  image: Configuration.instance.business.appLogo,
                  width: logoWidth * (animation.value < 0.5 ? (animation.value + 0.5) : (1.5 - animation.value)),
                ),
              ),
              Opacity(
                opacity: (animation.value < 1 ? 0 : animation.value),
                child: Transform.translate(
                  offset: Offset(logoWidth * 0.3, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Configuration.instance.business.appName,
                        style: Theme.of(context).textTheme.headline4!,
                      ),
                      Text(
                        Configuration.instance.business.appBio,
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
