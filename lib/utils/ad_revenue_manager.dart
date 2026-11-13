import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/providers/premium/premium_service.dart';

/// Production ad revenue optimizer (interstitial + app resume + high-value).
/// Banner still uses [AdView].
/// Pattern mirrored from StillHere.
///
/// Rules:
/// - Interstitial cooldown: 45s
/// - Max interstitial / session: 5
/// - App open: min 45s background, 2 min between opens
/// - First 2 high-value actions in session: skip cooldown
/// - Premium users never see ads
class AdRevenueManager with WidgetsBindingObserver {
  AdRevenueManager._();
  static final AdRevenueManager instance = AdRevenueManager._();

  Duration interstitialCooldown = const Duration(seconds: 45);
  int maxInterstitialPerSession = 5;
  Duration appOpenCooldown = const Duration(minutes: 2);
  Duration minBackgroundForAppOpen = const Duration(seconds: 45);

  DateTime? _lastInterstitialAt;
  DateTime? _lastAppOpenAt;
  DateTime? _pausedAt;
  int _sessionInterstitialCount = 0;
  int _actionCount = 0;
  bool _bound = false;
  bool _isShowing = false;

  AwesomeAdvertisement get _ads => ManagerProvider.of<AwesomeAdvertisement>();

  bool get _adsEnabled =>
      Configuration.instance.advertisement.enable &&
      !PremiumService.instance.isPremium;

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

  /// Call when user starts a fresh "session" (e.g. tool selected).
  void resetSessionCounters() {
    _sessionInterstitialCount = 0;
    _actionCount = 0;
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
    if (away < minBackgroundForAppOpen) return;

    if (_lastAppOpenAt != null) {
      final Duration sinceOpen = DateTime.now().difference(_lastAppOpenAt!);
      if (sinceOpen < appOpenCooldown) return;
    }

    _lastAppOpenAt = DateTime.now();
    _fireAd('app_resume', skipCooldown: false);
  }

  /// When user starts a tool / session.
  void onSessionStart() {
    if (!_adsEnabled) return;
    if (_sessionInterstitialCount == 0) {
      _fireAd('session_start', skipCooldown: true);
    }
  }

  /// After AI / save / export — high eCPM placement.
  void onHighValueAction({String placement = 'high_value'}) {
    if (!_adsEnabled) return;
    _actionCount++;
    final bool skip = _actionCount <= 2;
    _fireAd(placement, skipCooldown: skip);
  }

  /// Large screen transitions.
  void onNavigation({String placement = 'navigation'}) {
    if (!_adsEnabled) return;
    _fireAd(placement, skipCooldown: false);
  }

  /// Compatibility alias used by older call sites.
  void handleAd({String placement = 'legacy'}) {
    onHighValueAction(placement: placement);
  }

  void _fireAd(String placement, {required bool skipCooldown}) {
    try {
      if (_isShowing) {
        Debug.log('[AdRevenue] skip $placement — already showing');
        return;
      }
      if (_sessionInterstitialCount >= maxInterstitialPerSession) {
        Debug.log(
          '[AdRevenue] skip $placement — session cap '
          '$_sessionInterstitialCount/$maxInterstitialPerSession',
        );
        return;
      }
      if (!skipCooldown && _lastInterstitialAt != null) {
        final Duration delta = DateTime.now().difference(_lastInterstitialAt!);
        if (delta < interstitialCooldown) {
          final int left = interstitialCooldown.inSeconds - delta.inSeconds;
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
      _isShowing = true;
      // handleAd now only selects interstitial/reward (splash is excluded).
      // Keep _isShowing true long enough for a typical interstitial (skip ~5s + close).
      _ads.handleAd();
      Future.delayed(const Duration(seconds: 12), () {
        _isShowing = false;
      });
    } catch (e) {
      _isShowing = false;
      Debug.log('[AdRevenue] error: $e');
    }
  }

  int get sessionInterstitialCount => _sessionInterstitialCount;
  int get actionCount => _actionCount;
}
