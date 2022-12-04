// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:snapedit/widgets/load_more/source_list.dart';

class SliverListLoadMore<T> extends StatefulWidget {
  const SliverListLoadMore({
    super.key,
    this.maxLength = 300,
    this.padding = EdgeInsets.zero,
    required this.itemBuilder,
    required this.loadMore,
    this.indicatorBuilder,
  });

  final Future<List<T>> Function(int page, bool isloadMoreAction) loadMore;

  final Widget Function(BuildContext, T, int) itemBuilder;

  final int maxLength;

  final EdgeInsetsGeometry padding;

  final Widget? Function(BuildContext, IndicatorStatus)? indicatorBuilder;

  @override
  _SliverListLoadMoreState<T> createState() => _SliverListLoadMoreState<T>();
}

class _SliverListLoadMoreState<T> extends State<SliverListLoadMore<T>> {
  late SourceList<T> sourceList;
  @override
  void initState() {
    sourceList = SourceList(
      maxLength: widget.maxLength,
      loadMoreData: widget.loadMore,
    );
    super.initState();
  }

  @override
  void dispose() {
    sourceList.dispose();
    super.dispose();
  }

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
            sourceList: sourceList,
          ),
        ),
      ],
    );
  }
}
