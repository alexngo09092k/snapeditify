import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/modules/advertisement/app_lifecycle/app_lifecycle_reactor.dart';
import 'package:snapedit/services/services.dart';
import 'package:snapedit/widgets/base_screen.dart';

abstract class CustomOverlayState<T extends StatefulWidget> extends BaseScreen<T> with TickerProviderStateMixin {
  double bottomBarHeight = kBottomNavigationBarHeight - 15;

  OverlayEntry? _overlayEntry;

  final _tag = 'custom-overlay';

  late final StreamController<bool> _overlayController;

  late final AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    _overlayController = StreamController<bool>.broadcast()..add(false);
    _appLifecycleReactor = AppLifecycleReactor(handler: Services().advertisement);
    _appLifecycleReactor.listenToAppStateChanges();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      printLog('addPostFrameCallback $timeStamp');
      EasyDebounce.debounce(_tag, const Duration(milliseconds: 500), () {
        _overlayEntry = _buildOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry!);
        Services().advertisement.handleAd();
        _overlayController.sink.add(true);
      });
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
                      if(Cofiguration.isPutted)
                      const SizedBox()
                      // Services().advertisement.getAdWidget(),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
