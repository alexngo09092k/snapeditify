import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/common/configuration.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/models/config/app_config.dart';
import 'package:phosart/widgets/widget.utils.dart';
import 'package:phosart/common/extensions.dart';

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
    if (resultOnWillSplash && await ClientHttp.instance.shouldSendRequest()) {
      _goTo();
    } else {
      showNoInternetPopup(
        context,
        (_) {
          if (AwesomeApp.instance != null) {
            AwesomeApp.instance!.restart().then((value) {
              onSplash(true);
            });
          }
        },
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
    switch (Configuration.instance.businessConfig.appMode) {
      case AppMode.debug:
      case AppMode.production:
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.homePage, (_) => false);
        break;
      case AppMode.maintenance:
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.homePage, (_) => false);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          children: [
                            Image.asset(
                              AppAssets.instance.snapEditLogoFull,
                              width: AwesomeAppState.screen.width * 1.6 / 3,
                            ),
                            SizedBox(height: AppDimensions.instance.padding),
                            Image.asset(
                              AppAssets.instance.splashTitle,
                              width: AwesomeAppState.screen.width * 1.5 / 3,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: AppDimensions.instance.padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.instance.snapEditCopyRightTitle,
                    width: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
