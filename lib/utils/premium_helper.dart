import 'package:snapeditify/providers/premium/premium_service.dart';

/// Thin aliases kept for call sites that used the previous helper.
bool get isUserPremium => PremiumService.instance.isPremium;
