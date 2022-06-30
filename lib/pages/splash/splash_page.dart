import 'package:flutter/material.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/controllers/splash/splash_controller.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/widgets/static_splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late final SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashController(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _globalKey, body: _buildSplash(context));
  }

  Widget _buildSplash(BuildContext context) {
    return StaticSplash(
      backgroundcolor: Theme.of(context).backgroundColor,
      onEnd: _controller.goToNextScreen,
      duration: const Duration(milliseconds: 1000),
      image: Cofiguration.appConfig.logo,
      message: S.of(context).aiPowredPhotoEditor,
    );
  }
}
