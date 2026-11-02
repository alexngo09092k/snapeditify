import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class HomeLocalizations extends StatelessWidget {
  const HomeLocalizations({super.key});

  void _showLocalizationsSelections(BuildContext context) {
    WidgetUtils.instance.showDialog(
      builder: (_) => _LocalizationsPopup(
        onSelectedLocale: (Locale locale) {
          final provider = ManagerProvider.of<IThemeProvider>();
          provider.changeLocale(locale);
          WidgetUtils.instance.dismiss();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: S.of(context).languages,
      onPressed: () => _showLocalizationsSelections(context),
      icon: const Icon(Icons.language_rounded),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.5)),
    );
  }
}

class _LocalizationsPopup extends StatelessWidget {
  const _LocalizationsPopup({required this.onSelectedLocale});

  final Function(Locale locale) onSelectedLocale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final locales = S.delegate.supportedLocales;
    final maxHeight = AwesomeAppState.screen.height * 0.58;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: 480),
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: AppDimensions.instance.paddingX(0.5),
          ).copyWith(bottom: AppDimensions.instance.paddingX(0.5)),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: cs.onSurface.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.instance.padding,
                    AppDimensions.instance.padding,
                    AppDimensions.instance.paddingX(0.5),
                    AppDimensions.instance.paddingX(0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              cs.primary.withOpacity(0.9),
                              cs.primary.withOpacity(0.65),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.translate_rounded,
                          color: cs.onPrimary,
                          size: 22,
                        ),
                      ),
                      SizedBox(width: AppDimensions.instance.paddingX(0.85)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).languages,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${locales.length}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: cs.onSurface.withOpacity(0.55),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => WidgetUtils.instance.dismiss(),
                        icon: Icon(
                          Icons.close_rounded,
                          color: cs.onSurface.withOpacity(0.55),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: cs.outlineVariant.withOpacity(0.35),
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(
                      AppDimensions.instance.padding,
                      AppDimensions.instance.paddingX(0.85),
                      AppDimensions.instance.padding,
                      AppDimensions.instance.padding,
                    ),
                    itemCount: locales.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: AppDimensions.instance.paddingX(0.65)),
                    itemBuilder: (_, index) => _LocalizationItem(
                      locale: locales[index],
                      onSelectedLocale: onSelectedLocale,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocalizationItem extends StatelessWidget {
  const _LocalizationItem({
    required this.locale,
    required this.onSelectedLocale,
  });

  final Locale locale;
  final Function(Locale locale) onSelectedLocale;

  String _nativeName(BuildContext context) {
    switch (locale.languageCode) {
      case 'en':
        return S.of(context).english;
      case 'vi':
        return S.of(context).vietnamese;
      case 'zh':
        return S.of(context).chinese;
      case 'th':
        return S.of(context).thailand;
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  String get _subtitle {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'vi':
        return 'Tiếng Việt';
      case 'zh':
        return '中文';
      case 'th':
        return 'ภาษาไทย';
      default:
        return locale.languageCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final flagPath = '${AppAssets.flagPath}/${locale.languageCode}.png';

    return PropConsumer<IThemeProvider, Locale>(
      select: (_) => _.locale,
      builder: (_, __, ___, selectedLocale) {
        final selected = selectedLocale == locale;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: selected
                ? LinearGradient(
                    colors: [
                      cs.primary.withOpacity(0.14),
                      cs.primary.withOpacity(0.06),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: selected ? null : cs.surfaceVariant.withOpacity(0.35),
            border: Border.all(
              color: selected
                  ? cs.primary.withOpacity(0.85)
                  : cs.outlineVariant.withOpacity(0.25),
              width: selected ? 1.5 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: cs.primary.withOpacity(0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onSelectedLocale(locale),
              borderRadius: BorderRadius.circular(16),
              splashColor: cs.primary.withOpacity(0.08),
              highlightColor: cs.primary.withOpacity(0.04),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cs.surface,
                        border: Border.all(
                          color: selected
                              ? cs.primary.withOpacity(0.35)
                              : cs.outlineVariant.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: ClipOval(
                        child: CustomImage(
                          image: flagPath,
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _nativeName(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: selected ? cs.primary : cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurface.withOpacity(0.55),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: selected
                          ? Container(
                              key: const ValueKey('on'),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: cs.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check_rounded,
                                size: 18,
                                color: cs.onPrimary,
                              ),
                            )
                          : Container(
                              key: const ValueKey('off'),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: cs.outlineVariant.withOpacity(0.6),
                                  width: 1.5,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
