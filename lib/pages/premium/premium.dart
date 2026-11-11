import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_iap/fluttering_iap.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/premium/premium_service.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';

import 'premium_description.dart';
import 'premium_product_list.dart';

/// Modern Premium paywall — StillHere entitlement + SnapEditify UI.
class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage>
    with SingleTickerProviderStateMixin {
  IAPProduct? _selected;
  bool _purchasing = false;
  bool _restoring = false;
  String? _error;
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    PremiumService.instance.addListener(_onChanged);
    AwesomeIAP.instance.addListener(_onChanged);
    PremiumService.instance.syncFromIap();
  }

  @override
  void dispose() {
    PremiumService.instance.removeListener(_onChanged);
    AwesomeIAP.instance.removeListener(_onChanged);
    _pulse.dispose();
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _purchase() async {
    final product = _selected;
    if (product == null || _purchasing) return;
    setState(() {
      _purchasing = true;
      _error = null;
    });
    try {
      final ok = await PremiumService.instance.purchase(product);
      if (!mounted) return;
      if (ok) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('🎉 Premium unlocked — ads removed!'),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
        await Future<void>.delayed(const Duration(milliseconds: 700));
        if (mounted) Navigator.of(context).maybePop();
      } else {
        setState(() => _error = 'Purchase incomplete. Please try again.');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Purchase failed. Please try again.');
        Debug.log('Premium purchase error: $e');
      }
    } finally {
      if (mounted) setState(() => _purchasing = false);
    }
  }

  Future<void> _restore() async {
    if (_restoring) return;
    setState(() {
      _restoring = true;
      _error = null;
    });
    try {
      await PremiumService.instance.restore();
      if (!mounted) return;
      final ok = PremiumService.instance.isPremium;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ok
                ? 'Purchases restored — welcome back!'
                : 'No previous purchases found.',
          ),
          backgroundColor: ok
              ? const Color(0xFF10B981)
              : Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      if (ok) {
        await Future<void>.delayed(const Duration(milliseconds: 700));
        if (mounted) Navigator.of(context).maybePop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Restore failed. Please try again.');
        Debug.log('Premium restore error: $e');
      }
    } finally {
      if (mounted) setState(() => _restoring = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final pad = AppDimensions.instance.padding;
    final premium = PremiumService.instance.isPremium;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          Positioned(
            top: -80,
            left: -40,
            right: -40,
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (_, __) {
                final t = _pulse.value;
                return Container(
                  height: 320,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.2),
                      radius: 0.95,
                      colors: [
                        AppColors.brand.withOpacity(0.22 + t * 0.08),
                        AppColors.accent.withOpacity(0.10 + t * 0.04),
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad * 0.5),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: Icon(
                          CupertinoIcons.xmark,
                          size: 20,
                          color:
                              theme.colorScheme.onBackground.withOpacity(0.7),
                        ),
                      ),
                      const Spacer(),
                      if (premium)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.instance.gradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified,
                                  color: Colors.white, size: 14),
                              SizedBox(width: 6),
                              Text(
                                'Premium Active',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Spacer(),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(pad, 8, pad, pad),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.instance.heroGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.brand.withOpacity(0.35),
                                  blurRadius: 28,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.workspace_premium_rounded,
                              color: Colors.white,
                              size: 44,
                            ),
                          ),
                        ),
                        SizedBox(height: pad * 1.25),
                        Text(
                          s.unlockSnapeditifyPremium,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                            height: 1.15,
                          ),
                        ),
                        SizedBox(height: pad * 0.5),
                        Text(
                          premium
                              ? 'Thank you for supporting SnapEditify'
                              : s.noAdsBestImageQuality,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.35,
                          ),
                        ),
                        SizedBox(height: pad * 1.5),
                        const PremiumDescription(),
                        SizedBox(height: pad * 1.5),
                        if (_error != null) ...[
                          Text(
                            _error!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: pad * 0.75),
                        ],
                        if (!premium) ...[
                          PremiumProductList(
                            selected: _selected,
                            onSelect: (p) => setState(() => _selected = p),
                          ),
                          SizedBox(height: pad * 1.25),
                          CustomButton(
                            title: _selected == null
                                ? s.getIt
                                : 'Continue · ${_selected!.info?.price ?? ''}',
                            gradient: AppColors.instance.gradient,
                            height: 54,
                            titleSize: 16,
                            isLoading: _purchasing,
                            onTap: _selected == null || _purchasing
                                ? null
                                : _purchase,
                          ),
                          SizedBox(height: pad * 0.75),
                          Center(
                            child: TextButton(
                              onPressed: _restoring ? null : _restore,
                              child: _restoring
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CupertinoActivityIndicator(),
                                    )
                                  : Text(
                                      s.restore,
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: pad * 0.5),
                          Text(
                            'Cancel anytime · Auto-renewable subscription',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant
                                  .withOpacity(0.7),
                              fontSize: 11,
                            ),
                          ),
                        ] else ...[
                          CustomButton(
                            title: "You're Premium ✨",
                            gradient: AppColors.instance.gradient,
                            height: 54,
                            titleSize: 16,
                            onTap: () => Navigator.of(context).maybePop(),
                          ),
                        ],
                        SizedBox(height: pad),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
