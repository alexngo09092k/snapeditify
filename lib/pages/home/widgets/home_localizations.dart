import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/widgets/base/cupertino_block.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class HomeLocalizations extends StatelessWidget {
  const HomeLocalizations({super.key});

  _onSelectedLocale(BuildContext context, Locale locale) {
    final provider = ManagerProvider.of<IThemeProvider>();
    provider.changeLocale(locale);
    Navigator.of(context).pop();
  }

  _showLocalizationsSelections(BuildContext context) {
    Map<String, String> languageNames = {
      'en': S.of(context).english,
      'vi': S.of(context).vietnamese,
      'zh': S.of(context).chinese,
      'th': S.of(context).thailand,
    };
    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => CupertinoBlock(
        child: CupertinoActionSheet(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.language, color: Theme.of(context).textTheme.titleLarge!.color,),
            SizedBox(width: AppDimensions.instance.paddingX(0.5)),
            Text(S.of(context).languages, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600)),
          ],),
          actions: <CupertinoActionSheetAction>[
            ...S.delegate.supportedLocales.map(
              (locale) => CupertinoActionSheetAction(
                  onPressed: () => _onSelectedLocale(context, locale),
                  child: PropConsumer<IThemeProvider, String>(
                    select: (_) => _.locale.languageCode,
                    builder: (_, __, p, ___) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: AwesomeAppState.screen.width * 1.5/3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomImage(
                                image: '${AppAssets.flagPath}/${locale.languageCode}.png',
                                height: Theme.of(context).iconTheme.size,
                              ),
                              SizedBox(width: AppDimensions.instance.padding),
                              Text(
                                languageNames[locale.languageCode] ?? "",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: locale.languageCode == p.locale.languageCode? Theme.of(context).primaryColor: null),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
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
