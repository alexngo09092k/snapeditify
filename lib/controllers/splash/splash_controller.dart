import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snapretouch/common/app_routes.dart';
import 'package:snapretouch/controllers/splash/splash_state.dart';

class SplashController extends ValueNotifier<SplashState> {
  SplashController({required this.context}) : super(SplashState()) {
    initial();
  }

  final BuildContext context;

  final String _nextScreen = AppRoutes.home;
  bool _ok = false;
  int _count = 0;
  Timer? _timer;

  void initial() async {
    _ok = true;
  }

  Future<void> goToNextScreen() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _count++;
      if (_ok) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          _nextScreen,
          (route) => false,
        );
        timer.cancel();
      }
      if (_count > 5) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
