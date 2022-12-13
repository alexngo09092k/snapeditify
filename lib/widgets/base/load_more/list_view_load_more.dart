// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:snapedit/widgets/base/load_more/source_list.dart';

class ListViewLoadMore<T> extends StatefulWidget {
  const ListViewLoadMore({
    super.key,
    this.padding = EdgeInsets.zero,
    required this.itemBuilder,
    required this.sourceList,
    this.indicatorBuilder,
  });

  final SourceList<T> sourceList;

  final Widget Function(BuildContext, T, int) itemBuilder;

  final EdgeInsetsGeometry padding;

  final Widget? Function(BuildContext, IndicatorStatus)? indicatorBuilder;

  @override
  _ListViewLoadMoreState<T> createState() => _ListViewLoadMoreState<T>();
}

class _ListViewLoadMoreState<T> extends State<ListViewLoadMore<T>> {
  @override
  Widget build(BuildContext context) {
    return LoadingMoreList<T>(
      ListConfig<T>(
        itemBuilder: widget.itemBuilder,
        sourceList: widget.sourceList,
        indicatorBuilder: widget.indicatorBuilder,
        physics: const FixedOverscrollBouncingScrollPhysics(),
        padding: const EdgeInsets.all(0.0),
        extendedListDelegate: ExtendedListDelegate(
          collectGarbage: (List<int> indexes) {},
        ),
      ),
    );
  }
}
