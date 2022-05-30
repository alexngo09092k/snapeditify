import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/splash/splash_controller.dart';
import 'package:snapedit/widgets/static_splash.dart';

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
    _controller.setNextScreen();
  }

  @override
  void dispose() {
    super.dispose();
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
      image: AppImages.imgSplashLogoNormal3x,
    );
  }
}
