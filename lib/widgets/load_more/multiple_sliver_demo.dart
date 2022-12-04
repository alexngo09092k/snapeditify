// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:snapedit/widgets/load_more/source_list.dart';

class MultipleSliverLoadMore extends StatefulWidget {
  final List<MultipleSliverSourceList> list;

  const MultipleSliverLoadMore({super.key, required this.list});

  @override
  _MultipleSliverLoadMoreState createState() => _MultipleSliverLoadMoreState();
}

class _MultipleSliverLoadMoreState extends State<MultipleSliverLoadMore> {
  final List<Widget> _slivers = [];

  @override
  void initState() {
    for (var item in widget.list) {
      if (item.headerBuilder != null) {
        _slivers.add(item.headerBuilder!(context));
      }
      _slivers.add(
        LoadingMoreSliverList(
          SliverListConfig(
            itemBuilder: item.itemBuilder,
            sourceList: item.sourceList,
            padding: item.padding,
            extendedListDelegate: item.extendedListDelegate,
            gridDelegate: item.gridDelegate,
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingMoreCustomScrollView(slivers: _slivers);
  }
}
