import 'package:flutter/material.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/app_shared.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/splash/splash_state.dart';

class SplashController extends ValueNotifier<SplashState> {
  SplashController({required this.context}) : super(SplashState());

  final BuildContext context;

  String? _nextScreen;
  bool _wentNext = false;

  void setNextScreen() async {
    final String? image = AppShared.sharedPreferences != null
        ? AppShared.sharedPreferences!.getString(AppSharedKey.image)
        : null;
    if (image != null) {
      _nextScreen = AppRoutes.edit;
    }
    _nextScreen = AppRoutes.home;
  }

  Future<void> goToNextScreen() async {
    if (_nextScreen != null) {
      _wentNext = true;
      Navigator.pushNamedAndRemoveUntil(
          context, _nextScreen!, (route) => false);
    } else {
      await Future.delayed(const Duration(milliseconds: 1000), () async {
        if (!_wentNext) {
          await goToNextScreen();
        }
      });
    }
  }
}
