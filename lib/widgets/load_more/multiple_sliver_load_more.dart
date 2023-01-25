// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:snapeditify/widgets/load_more/source_list.dart';

class MultipleSliverLoadMore<T> extends StatefulWidget {
  final List<MultipleSliverSourceList<T>> list;

  const MultipleSliverLoadMore({super.key, required this.list});

  @override
  _MultipleSliverLoadMoreState<T> createState() => _MultipleSliverLoadMoreState<T>();
}

class _MultipleSliverLoadMoreState<T> extends State<MultipleSliverLoadMore<T>> {
  final List<Widget> _slivers = [];

  @override
  void initState() {
    for (var item in widget.list) {
      if (item.headerBuilder != null) {
        _slivers.add(item.headerBuilder!(context, item));
      }
      if (item.sourceList != null && item.itemBuilder != null) {
        _slivers.add(
          LoadingMoreSliverList<T>(
            SliverListConfig<T>(
              itemBuilder: item.itemBuilder!,
              sourceList: item.sourceList!,
              padding: item.padding,
              extendedListDelegate: item.extendedListDelegate,
              gridDelegate: item.gridDelegate,
            ),
          ),
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingMoreCustomScrollView(slivers: _slivers);
  }
}
