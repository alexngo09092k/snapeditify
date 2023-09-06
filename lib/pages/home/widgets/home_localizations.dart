import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class HomeLocalizations extends StatelessWidget {
  const HomeLocalizations({super.key});

  _showLocalizationsSelections(BuildContext context) {
    return WidgetUtils.instance.showDialog(
      builder: (_) => _LocalizationsPopup(onSelectedLocale: (Locale locale) {
        final provider = ManagerProvider.of<IThemeProvider>();
        provider.changeLocale(locale);
        WidgetUtils.instance.dimiss();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLocalizationsSelections(context),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.5)),
        child: const Icon(Icons.language),
      ),
    );
  }
}

class _LocalizationsPopup extends StatelessWidget {
  const _LocalizationsPopup({required this.onSelectedLocale});

  final Function(Locale locale) onSelectedLocale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AwesomeAppState.screen.height * 0.7),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.instance.radius),
          topRight: Radius.circular(AppDimensions.instance.radius),
        )
      ),
      height: AwesomeAppState.screen.height * 4 / 5,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppDimensions.instance.padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomIcon(Icons.language),
                SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                Text(
                  "Languages", 
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: S.delegate.supportedLocales.length,
                itemBuilder: (_, index) => _LocalizationItem(
                  locale: S.delegate.supportedLocales[index],
                  onSelectedLocale: onSelectedLocale,
                  isStart: index == 0,
                  isEnd: index + 1 == S.delegate.supportedLocales.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocalizationItem extends StatelessWidget {
  const _LocalizationItem({
    required this.locale, 
    required this.onSelectedLocale,
    required this.isStart,
    required this.isEnd,
  });
  final Locale locale;
  final bool isStart;
  final bool isEnd;
  final Function(Locale locale) onSelectedLocale;

  @override
  Widget build(BuildContext context) {
    Map<String, String> languageNames = {
      'en': S.of(context).english,
      'vi': S.of(context).vietnamese,
      'zh': S.of(context).chinese,
      'th': S.of(context).thailand,
    };
    return GestureDetector(
      onTap: () => onSelectedLocale(locale),
      child: LayoutBuilder(builder: (_, constrains) {
        double height = constrains.maxHeight - AppDimensions.instance.paddingX(2);
        double width = height;
        return AppCard(
          margin: EdgeInsets.symmetric(
            horizontal: AppDimensions.instance.paddingX(0.5),
            vertical: AppDimensions.instance.padding,
          ).copyWith(
            left: isStart ? AppDimensions.instance.padding: null,
            right: isEnd? AppDimensions.instance.padding: null,
          ),
          width: width,
          height: height,
          child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
            child: Column(
              children: [
                ClipRRect(borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                  child: CustomImage(
                    image: '${AppAssets.flagPath}/${locale.languageCode}.png',
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PropConsumer<IThemeProvider, Locale>(
                      select: (_) => _.locale,
                      builder: (_, __, ___, selectedLocale) {
                        if (selectedLocale != locale) {
                          return SizedBox(height: AppDimensions.instance.icon);
                        }
                        return Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary);
                      },
                    ),
                    SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                    Text(
                      languageNames[locale.languageCode] ?? "",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
               
              ],
            ),
          ),
        );
      }),
    );
  }
}
