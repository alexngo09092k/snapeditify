import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/restyle/restyle_provider.dart';
import 'package:phosart/services/snap_edit/src/models/response/styles_response.dart';
import 'package:phosart/widgets/base/app_card.dart';
import 'package:phosart/widgets/base/custom_image.dart';

class StyleList extends StatelessWidget {
  const StyleList({super.key, required this.provider});
  final RestyleProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.5), vertical: AppDimensions.instance.padding),
      child: BasePropConsumer<RestyleProvider, int>(
        listenable: provider,
        select: (_) => _.styles.length,
        builder: (_, __, p, ___) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: p.styles.length,
          itemBuilder: (_, index) => StyleItem(
            key: Key('$index'),
            provider: provider,
            style: p.styles[index],
          ),
        ),
      ),
    );
  }
}

class StyleItem extends StatelessWidget {
  const StyleItem({super.key, required this.provider, required this.style});
  final RestyleProvider provider;
  final Style style;

  _onStyle() {
    provider.restyleImage(style.styleId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.5), vertical: AppDimensions.instance.padding),
      width: (180 * 1.7 / 3),
      child: GestureDetector(
        onTap: () => _onStyle(),
        child: AppCard(
          width: AwesomeAppState.screen.width / 4.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                child: Stack(
                  children: [
                    CustomImage(
                      image: style.thumbnailUrl,
                    ),
                    Positioned(
                      right: 0,
                      child: BasePropConsumer<RestyleProvider, String?>(
                        listenable: provider,
                        select: (_) => _.state.styleId,
                        builder: (_, __, p, ___) => p.state.styleId == style.styleId
                            ? Padding(
                                padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.1)),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    style.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
