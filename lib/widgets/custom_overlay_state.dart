import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/services/advertisement/app_lifecycle/app_lifecycle_handler.dart';
import 'package:snapretouch/services/advertisement/app_lifecycle/app_lifecycle_reactor.dart';
import 'package:snapretouch/services/services.dart';
import 'package:snapretouch/widgets/base_screen.dart';

class OverlayControlDelegate {
  Function(String? nameRoute)? emitRoute;
  Function(String? nameRoute)? emitTab;
  static OverlayControlDelegate? _instance;

  factory OverlayControlDelegate() {
    return _instance ??= OverlayControlDelegate._();
  }

  OverlayControlDelegate._();
}

abstract class CustomOverlayState<T extends StatefulWidget> extends BaseScreen<T> with TickerProviderStateMixin, AppLifeCycleHandler{
  double bottomBarHeight = kBottomNavigationBarHeight - 15;

  OverlayEntry? _overlayEntry;

  final _tag = 'custom-overlay';

  late final StreamController<bool> _overlayController;

  late final AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    _overlayController = StreamController<bool>.broadcast()..add(false);
    _appLifecycleReactor =
        AppLifecycleReactor(handler: this);
    _appLifecycleReactor.listenToAppStateChanges();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    EasyDebounce.debounce(_tag, const Duration(milliseconds: 500), () {
      OverlayControlDelegate().emitRoute = (String? screenName) {
        printLog('screenName $screenName');
        Services().advertisement.handleAd(screenName: screenName);
        _overlayController.sink.add(true);
      };
      _overlayEntry = _buildOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
      _overlayController.sink.add(true);
    });
  }

  @override
  void dispose() {
    EasyDebounce.cancel(_tag);
    _overlayEntry?.remove();
    super.dispose();
  }

  OverlayEntry _buildOverlayEntry() {
    return OverlayEntry(
      builder: (_) {
        return StreamBuilder<bool>(
            stream: _overlayController.stream,
            builder: (context, snapshot) {
              if (snapshot.data == false) return const SizedBox();
              return Positioned(
                bottom: bottomBarHeight + MediaQuery.of(_).padding.bottom,
                left: 0,
                right: 0,
                child: Material(
                  type: MaterialType.transparency,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (Cofiguration.isPutted) const SizedBox(),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
