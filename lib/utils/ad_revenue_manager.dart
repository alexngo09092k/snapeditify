import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapeditify/common/configuration.dart';

/// Tối ưu doanh thu ads (interstitial + app resume).
/// Banner vẫn dùng [AdView] như cũ.
class AdRevenueManager with WidgetsBindingObserver {
  AdRevenueManager._();
  static final AdRevenueManager instance = AdRevenueManager._();

  /// Khoảng tối thiểu giữa 2 interstitial.
  final Duration _interstitialCooldown = const Duration(seconds: 18);

  /// App open / resume
  final Duration _appOpenCooldown = const Duration(minutes: 2);
  final Duration _minBackgroundForAppOpen = const Duration(seconds: 45);

  DateTime? _lastInterstitialAt;
  DateTime? _lastAppOpenAt;
  DateTime? _pausedAt;
  int _sessionInterstitialCount = 0;
  int _actionCount = 0;
  bool _bound = false;

  AwesomeAdvertisement get _ads => ManagerProvider.of<AwesomeAdvertisement>();

  bool get _adsEnabled => Configuration.instance.advertisement.enable;

  void bind() {
    if (_bound) return;
    _bound = true;
    WidgetsBinding.instance.addObserver(this);
  }

  void unbind() {
    if (!_bound) return;
    _bound = false;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _pausedAt = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      _onResumed();
    }
  }

  void _onResumed() {
    if (!_adsEnabled) return;
    final DateTime? paused = _pausedAt;
    if (paused == null) return;

    final Duration away = DateTime.now().difference(paused);
    if (away < _minBackgroundForAppOpen) return;

    if (_lastAppOpenAt != null) {
      final Duration sinceOpen = DateTime.now().difference(_lastAppOpenAt!);
      if (sinceOpen < _appOpenCooldown) return;
    }

    _lastAppOpenAt = DateTime.now();
    _fireAd('app_resume', skipCooldown: false);
  }

  /// Khi user chọn tool → vào albums.
  void onSessionStart() {
    if (!_adsEnabled) return;
    if (_sessionInterstitialCount == 0) {
      _fireAd('session_start', skipCooldown: true);
    }
  }

  /// Sau AI / save — điểm doanh thu cao.
  void onHighValueAction({String placement = 'high_value'}) {
    if (!_adsEnabled) return;
    _actionCount++;
    // 2 action đầu session: luôn hiện
    final bool skip = _actionCount <= 2;
    _fireAd(placement, skipCooldown: skip);
  }

  /// Khi chuyển màn lớn.
  void onNavigation({String placement = 'navigation'}) {
    if (!_adsEnabled) return;
    _fireAd(placement, skipCooldown: false);
  }

  /// Alias tương thích chỗ gọi cũ.
  void handleAd({String placement = 'legacy'}) {
    onHighValueAction(placement: placement);
  }

  void _fireAd(String placement, {required bool skipCooldown}) {
    try {
      if (!skipCooldown && _lastInterstitialAt != null) {
        final Duration delta = DateTime.now().difference(_lastInterstitialAt!);
        if (delta < _interstitialCooldown) {
          final int left = _interstitialCooldown.inSeconds - delta.inSeconds;
          Debug.log('[AdRevenue] skip $placement — cooldown ${left}s left');
          return;
        }
      }

      Debug.log(
        '[AdRevenue] show placement=$placement '
        'session=$_sessionInterstitialCount action=$_actionCount',
      );
      _lastInterstitialAt = DateTime.now();
      _sessionInterstitialCount++;
      _ads.handleAd();
    } catch (e) {
      Debug.log('[AdRevenue] error: $e');
    }
  }

  int get sessionInterstitialCount => _sessionInterstitialCount;
  int get actionCount => _actionCount;
}
