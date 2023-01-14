import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/anime_ai/anime_ai_provider.dart';

class AnimeAICategoryList extends StatelessWidget {
  const AnimeAICategoryList({super.key, required this.provider});
  final AnimeAIProvider provider;

  _onCategory(String category) {
    provider.category = category;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BasePropConsumer<AnimeAIProvider, int>(
        listenable: provider,
        select: (_) => _.categories.length,
        builder: (_, __, p, ___) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: p.categories.length,
          itemBuilder: (_, index) => Container(
            padding: EdgeInsets.only(left: AppDimensions.instance.padding),
            child: AnimeCategoryItem(
              key: Key('$index'),
              provider: provider,
              category: p.categories[index],
              onCategory: _onCategory,
            ),
          ),
        ),
      ),
    );
  }
}

class AnimeCategoryItem extends StatelessWidget {
  const AnimeCategoryItem({super.key, required this.provider, required this.category, required this.onCategory});
  final AnimeAIProvider provider;
  final String category;
  final Function(String) onCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.1), vertical: AppDimensions.instance.padding),
      child: GestureDetector(
        onTap: () => onCategory(category),
        child: BasePropConsumer<AnimeAIProvider, String?>(
          listenable: provider,
          select: (_) => _.category,
          builder: (_, __, p, ___) => Container(
            padding: EdgeInsets.symmetric(vertical: AppDimensions.instance.paddingX(0.5), horizontal: AppDimensions.instance.padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radiusX(2))),
              border: p.category == category ? Border.all(color: Theme.of(context).primaryColor) : null,
              color: p.category == category ? Theme.of(context).primaryColor.withOpacity(0.1) : Theme.of(context).disabledColor.withOpacity(0.1),
            ),
            child: Text(
              category,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: p.category == category ? Theme.of(context).primaryColor : null,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
