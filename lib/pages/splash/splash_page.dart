import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/models/config/app_config.dart';
import 'package:snapedit/widgets/app_logo.dart';
import 'package:snapedit/widgets/widget.utils.dart';
import 'package:snapedit/common/extensions.dart';

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
    switch (Configuration.instance.appConfig.appMode) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AwesomeAnimation<double>.tweenSequence(
            duration: const Duration(milliseconds: 1000),
            items: [
              TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 10),
              TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 1),
            ],
            builder: (_, __, animation, ___) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: animation.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppLogo(
                          width: MediaQuery.of(context).size.width * 0.8 / 2,
                          image: Configuration.instance.appConfig.appLogo,
                        ),
                        SizedBox(height: AppDimensions.instance.paddingSizeDefault),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
