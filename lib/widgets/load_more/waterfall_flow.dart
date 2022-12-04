// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:snapedit/widgets/load_more/source_list.dart';

class WaterfallFlow<T> extends StatefulWidget {
  const WaterfallFlow({
    super.key,
    this.maxLength = 300,
    this.padding = EdgeInsets.zero,
    this.extendedListDelegate = const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 300,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
    ),
    required this.itemBuilder,
    required this.loadMore,
    this.indicatorBuilder,
  });

  final Future<List<T>> Function(int page, bool isloadMoreAction) loadMore;

  final Widget Function(BuildContext, T, int) itemBuilder;

  final int maxLength;

  final EdgeInsetsGeometry padding;

  final Widget? Function(BuildContext, IndicatorStatus)? indicatorBuilder;

  final ExtendedListDelegate? extendedListDelegate;

  @override
  _WaterfallFlowState<T> createState() => _WaterfallFlowState<T>();
}

class _WaterfallFlowState<T> extends State<WaterfallFlow<T>> {
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
    return LoadingMoreList<T>(
      ListConfig<T>(
        extendedListDelegate: widget.extendedListDelegate,
        itemBuilder: widget.itemBuilder,
        sourceList: sourceList,
        padding: const EdgeInsets.all(5.0),
        lastChildLayoutType: LastChildLayoutType.foot,
      ),
    );
  }
}
