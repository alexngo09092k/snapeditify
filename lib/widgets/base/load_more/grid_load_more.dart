// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:loading_more_list/loading_more_list.dart';
import 'package:snapedit/widgets/base/load_more/source_list.dart';

class GridLoadMore<T> extends StatefulWidget {
  const GridLoadMore({
    super.key,
    this.padding = EdgeInsets.zero,
    this.gridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 300.0,
      crossAxisSpacing: 3.0,
      mainAxisSpacing: 3.0,
    ),
    required this.itemBuilder,
    required this.sourceList,
    this.indicatorBuilder,
  });

  final SourceList<T> sourceList;

  final Widget Function(BuildContext, T, int) itemBuilder;

  final EdgeInsetsGeometry padding;

  final SliverGridDelegate? gridDelegate;

  final Widget? Function(BuildContext, IndicatorStatus)? indicatorBuilder;

  @override
  _GridLoadMoreState<T> createState() => _GridLoadMoreState<T>();
}

class _GridLoadMoreState<T> extends State<GridLoadMore<T>> {
  @override
  Widget build(BuildContext context) {
    return LoadingMoreList<T>(
      ListConfig<T>(
        itemBuilder: widget.itemBuilder,
        sourceList: widget.sourceList,
        padding: widget.padding,
        indicatorBuilder: widget.indicatorBuilder,
        lastChildLayoutType: LastChildLayoutType.foot,
        gridDelegate: widget.gridDelegate,
      ),
    );
  }
}
