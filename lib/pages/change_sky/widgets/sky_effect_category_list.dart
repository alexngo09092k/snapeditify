import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/change_sky/widgets/sky_effect_list.dart';
import 'package:snapeditify/providers/change_sky/change_sky_provider.dart';
import 'package:snapeditify/services/services.dart';

class SkyEffectCategoryList extends StatefulWidget {
  const SkyEffectCategoryList({super.key});

  @override
  State<SkyEffectCategoryList> createState() => _SkyEffectCategoryListState();
}

class _SkyEffectCategoryListState extends ProviderStateObserver<SkyEffectCategoryList, IChangeSkyProvider> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: provider.categories.length, vsync: this);
  }

  void onEffect(Background effect) async {
    provider.changeSky(context, effect);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          PropConsumer<IChangeSkyProvider, List<String>>(
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
                  e, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),),
                )).toList(),
              );
            },
          ),
          Expanded(
            child: PropConsumer<IChangeSkyProvider, List<String>>(
              select: (_) => _.categories,
              builder: (_, __, p, categories) {
                if(categories.isEmpty) return const SizedBox();
                return TabBarView(
                    controller: _controller,
                    children: categories
                        .map((e) => SkyEffectList(category: e, onEffect: onEffect))
                        .toList());
              },
            ),
          )
        ],
      ),
    );
  }
}
