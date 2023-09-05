// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/pages/change_bg/widgets/bg_list.dart';
import 'package:snapeditify/providers/change_bg/change_bg_provider.dart';
import 'package:snapeditify/services/services.dart';

class ChangeBGControl extends StatefulWidget {
  const ChangeBGControl({super.key});

  @override
  State<ChangeBGControl> createState() => _ChangeBGControlState();
}

class _ChangeBGControlState extends ProviderStateObserver<ChangeBGControl, IChangeBGProvider> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: provider.categories.length, vsync: this);
  }

  void onBG(Background background) async {
      final String name = '${Configuration.instance.business.appName}_${DateTime.now().millisecond}';
      final Directory cacheDirectory = await getTemporaryDirectory();
      String savePath = "${cacheDirectory.path}/$name.jpg";
      await Dio().downloadUri(Uri.parse(background.url), savePath);
      provider.changeBGImage(context, File(savePath).readAsBytesSync());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Column(
        children: [
          PropConsumer<IChangeBGProvider, List<String>>(
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
            child: PropConsumer<IChangeBGProvider, List<String>>(
              select: (_) => _.categories,
              builder: (_, __, p, categories) {
                if(categories.isEmpty) return const SizedBox();
                return TabBarView(
                    controller: _controller,
                    children: categories
                        .map((e) => BGList(category: e, onBG: onBG))
                        .toList());
              },
            ),
          )
        ],
      ),
    );
  }
}
