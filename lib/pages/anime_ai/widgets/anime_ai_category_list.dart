import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';

class AnimeAICategoryList extends StatelessWidget {
  const AnimeAICategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: PropConsumer<IAnimeAIProvider, int>(
        select: (_) => _.categories.length,
        builder: (_, __, p, count) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: count,
          itemBuilder: (_, index) => Container(
            padding: EdgeInsets.only(left: AppDimensions.instance.padding),
            child: AnimeCategoryItem(
              key: Key('$index'),
              category: p.categories[index],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimeCategoryItem extends StatelessWidget {
  const AnimeCategoryItem({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.instance.paddingX(0.1),
        vertical: AppDimensions.instance.padding,
      ),
      child: PropConsumer<IAnimeAIProvider, String?>(
        select: (_) => _.category,
        builder: (_, __, p, c) => GestureDetector(
          onTap: () => p.category = category,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: AppDimensions.instance.paddingX(0.5),
              horizontal: AppDimensions.instance.padding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radiusX(2))),
              border: c == category
                  ? Border.all(color: Theme.of(context).primaryColor)
                  : null,
              color: c == category
                  ? Theme.of(context).primaryColor.withOpacity(0.1)
                  : Theme.of(context).disabledColor.withOpacity(0.1),
            ),
            child: Text(
              category,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
