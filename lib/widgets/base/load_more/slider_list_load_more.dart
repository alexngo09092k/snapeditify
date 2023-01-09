// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:phosart/widgets/base/load_more/source_list.dart';

class SliverListLoadMore<T> extends StatefulWidget {
  const SliverListLoadMore({
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
  _SliverListLoadMoreState<T> createState() => _SliverListLoadMoreState<T>();
}

class _SliverListLoadMoreState<T> extends State<SliverListLoadMore<T>> {
  @override
  Widget build(BuildContext context) {
    return LoadingMoreCustomScrollView(
      showGlowLeading: false,
      slivers: <Widget>[
        LoadingMoreSliverList<T>(
          SliverListConfig<T>(
            padding: widget.padding,
            itemBuilder: widget.itemBuilder,
            indicatorBuilder: widget.indicatorBuilder,
            sourceList: widget.sourceList,
          ),
        ),
      ],
    );
  }
}
