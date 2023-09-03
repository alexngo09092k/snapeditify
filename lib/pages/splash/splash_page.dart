// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/models/config/bussiness_config/bussiness_config.dart';
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
  void onSplash(bool resultOnWillSplash) async {
    final start = DateTime.now().millisecondsSinceEpoch;
    if (await ClientHttp.instance.safeEnvironment()) {
      if (resultOnWillSplash) {
        final end = DateTime.now().millisecondsSinceEpoch;
        if ((end - start) >= time) {
          _goTo();
        } else {
          Future.delayed(Duration(milliseconds: (time - ((end - start)))), _goTo);
        }
      } else {
        WidgetUtils.instance.showWarningPopup(
          title: S.of(context).openApp,
          message: S.of(context).pleaseTryAgainOrOpenTheAppAgain,
          retry: (_) => AwesomeApp.instance?.restart(),
        );
      }
    } else {
      WidgetUtils.instance.showNoInternetPopup(retry: (_) => onSplash(resultOnWillSplash));
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
    final logoWidth = AwesomeAppState.screen.width * 1 / 4;
    final textWidth = AwesomeAppState.screen.width * 1.5 / 3;
    final widthTotal = logoWidth + textWidth + AppDimensions.instance.padding;
    final logoAlpha = (widthTotal / 2 - logoWidth / 2);
    final textAlpha = (widthTotal / 2 - textWidth / 2);
    return Scaffold(
      body: Center(
        child: Transform.translate(
          offset: Offset(0, -logoWidth/3),
          child: AwesomeAnimation<double>.tweenSequence(
            duration: Duration(milliseconds: time - 200),
            items: [
              TweenSequenceItem(tween: Tween<double>(begin: 0, end: 0), weight: 0.6),
              TweenSequenceItem(tween: Tween<double>(begin: 0, end: 0.5), weight: 0.3),
              TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1), weight: 0.1),
            ],
            builder: (_, __, animation, ___) => Stack(
              alignment: Alignment.center,
              children: [
                Transform.translate(
                  offset: Offset(-logoAlpha * animation.value, 0),
                  child: CustomImage(
                    image: Configuration.instance.business.appLogo,
                    width: logoWidth * (2 - animation.value),
                  ),
                ),
                Transform.translate(
                  offset: Offset(textAlpha, 0),
                  child: SizedBox(
                    width: textWidth,
                    child: Opacity(
                      opacity: animation.value >= 1 ? 1 : 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              Configuration.instance.business.appName,
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            Configuration.instance.business.appBio,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
