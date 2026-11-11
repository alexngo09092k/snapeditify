import 'package:fluttering/fluttering.dart';
import 'package:fluttering_analytics/analytics/index.dart';
import 'package:fluttering_iap/fluttering_iap.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:snapeditify/common/constants.dart';

/// Single source of premium entitlement for SnapEditify.
/// Uses existing [AwesomeIAP] only — no parallel IAP manager.
/// Pattern mirrored from StillHere production implementation.
class PremiumService extends Provider {
  PremiumService._();
  static final PremiumService instance = PremiumService._();

  bool _isPremium = false;
  bool get isPremium => _isPremium;

  bool _bound = false;

  String get _premiumKey => AsyncStorageKey.instance.premium;

  /// True when user owns an active subscription (or non-consumable).
  /// SnapEditify ships subscription SKUs only; consumables never grant premium.
  bool _premiumFromProducts(List<IAPProduct> products) {
    return products.any(
      (p) =>
          p.status &&
          (p.type == IAPType.subscriptions || p.type == IAPType.nonConsumables),
    );
  }

  /// Call once after AwesomeIAP.initial.
  Future<void> bind() async {
    if (_bound) return;
    _bound = true;

    _isPremium = AsyncStorage.instance.getBool(_premiumKey) ?? false;
    notifyListeners();

    await syncFromIap();
    AwesomeIAP.instance.addListener(_onIapChanged);
  }

  void unbind() {
    if (!_bound) return;
    _bound = false;
    AwesomeIAP.instance.removeListener(_onIapChanged);
  }

  void _onIapChanged() {
    final fromIap = _premiumFromProducts(AwesomeIAP.instance.products);
    if (fromIap != _isPremium) {
      _setPremium(fromIap);
    }
  }

  Future<void> syncFromIap() async {
    try {
      final fromIap = _premiumFromProducts(AwesomeIAP.instance.products);
      if (fromIap) {
        await _setPremium(true);
      }
      // Do not force false from empty product list (store may still be loading).
    } catch (e) {
      Debug.log('[PremiumService] syncFromIap: $e');
    }
  }

  Future<void> _setPremium(bool value) async {
    if (_isPremium == value) {
      // Still persist so cold start is consistent.
      await AsyncStorage.instance.setBool(_premiumKey, value);
      return;
    }
    _isPremium = value;
    await AsyncStorage.instance.setBool(_premiumKey, value);
    notifyListeners();
    Debug.log('[PremiumService] isPremium=$value');
  }

  Future<bool> purchase(IAPProduct product) async {
    try {
      AwesomeAnalytics.instance.sendEvent('purchase_start', {
        'product_id': product.id,
        'provider': product.provider.name,
      });
      await AwesomeIAP.instance.purchase(product);
      await Future.delayed(const Duration(milliseconds: 800));
      await syncFromIap();
      if (_isPremium) {
        AwesomeAnalytics.instance.sendEvent('purchase_success', {
          'product_id': product.id,
        });
      }
      return _isPremium;
    } catch (e) {
      AwesomeAnalytics.instance.sendEvent('purchase_fail', {
        'product_id': product.id,
        'error': e.toString(),
      });
      Debug.log('[PremiumService] purchase error: $e');
      rethrow;
    }
  }

  /// Production restore: Google/Apple via InAppPurchase + Huawei via AwesomeIAP.restore().
  Future<void> restore() async {
    try {
      AwesomeAnalytics.instance.sendEvent('restore_start', {});

      // Google / Apple
      try {
        await InAppPurchase.instance.restorePurchases();
      } catch (e) {
        Debug.log('[PremiumService] InAppPurchase.restorePurchases: $e');
      }

      // Huawei (+ any provider restore implemented on BaseIAP)
      try {
        await AwesomeIAP.instance.restore();
      } catch (e) {
        Debug.log('[PremiumService] AwesomeIAP.restore: $e');
      }

      await Future.delayed(const Duration(milliseconds: 600));
      await syncFromIap();
      AwesomeAnalytics.instance.sendEvent(
        _isPremium ? 'restore_success' : 'restore_empty',
        {},
      );
    } catch (e) {
      AwesomeAnalytics.instance.sendEvent('restore_fail', {
        'error': e.toString(),
      });
      Debug.log('[PremiumService] restore error: $e');
      rethrow;
    }
  }

  List<IAPProduct> get products {
    final live = AwesomeIAP.instance.products;
    if (live.isNotEmpty) return live;
    return AwesomeIAP.instance.config.products;
  }

  List<IAPProduct> get availableProducts {
    final list = products.where((p) => p.info != null).toList();
    if (list.isNotEmpty) return list;
    // Fallback to config products (with static info) while store loads.
    return AwesomeIAP.instance.config.products
        .where((p) => p.info != null)
        .toList();
  }
}
