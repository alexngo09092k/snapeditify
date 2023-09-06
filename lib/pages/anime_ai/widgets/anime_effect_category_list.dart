// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/anime_ai/widgets/anime_effect_list.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/services/services.dart';

class AnimeEffectCategoryList extends StatefulWidget {
  const AnimeEffectCategoryList({super.key});

  @override
  State<AnimeEffectCategoryList> createState() => _AnimeEffectCategoryListState();
}

class _AnimeEffectCategoryListState extends ProviderStateObserver<AnimeEffectCategoryList, IAnimeAIProvider> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: provider.categories.length, vsync: this);
  }

  void onEffect(Effect effect) {
    provider.restyleImage(context, effect.styleId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          PropConsumer<IAnimeAIProvider, List<String>>(
            select: (_) => _.categories,
            builder: (_, __, p, categories) {
              if(categories.isEmpty) return const SizedBox();
              return TabBar(
                isScrollable: true,
                unselectedLabelColor: Theme.of(context).textTheme.bodyLarge!.color,
                labelColor: Theme.of(context).colorScheme.primary,
                indicatorColor: Theme.of(context).colorScheme.primary,
                controller: _controller,
                tabs: categories.map((e) => Tab(
                  child: Text(
                  e, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),),
                )).toList(),
              );
            },
          ),
          Expanded(
            child: PropConsumer<IAnimeAIProvider, List<String>>(
              select: (_) => _.categories,
              builder: (_, __, p, categories) {
                if(categories.isEmpty) return const SizedBox();
                return TabBarView(
                    controller: _controller,
                    children: categories
                        .map((e) => AnimeEffectList(category: e, onEffect: onEffect))
                        .toList());
              },
            ),
          )
        ],
      ),
    );
  }
}
