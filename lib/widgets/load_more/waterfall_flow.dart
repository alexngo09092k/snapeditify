// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:phosart/widgets/load_more/source_list.dart';

class WaterfallFlow<T> extends StatefulWidget {
  const WaterfallFlow({
    super.key,
    this.padding = EdgeInsets.zero,
    this.extendedListDelegate = const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 300,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
    ),
    required this.itemBuilder,
    required this.sourceList,
    this.indicatorBuilder,
  });

  final SourceList<T> sourceList;

  final Widget Function(BuildContext, T, int) itemBuilder;

  final EdgeInsetsGeometry padding;

  final Widget? Function(BuildContext, IndicatorStatus)? indicatorBuilder;

  final ExtendedListDelegate? extendedListDelegate;

  @override
  _WaterfallFlowState<T> createState() => _WaterfallFlowState<T>();
}

class _WaterfallFlowState<T> extends State<WaterfallFlow<T>> {
  @override
  Widget build(BuildContext context) {
    return LoadingMoreList<T>(
      ListConfig<T>(
        extendedListDelegate: widget.extendedListDelegate,
        itemBuilder: widget.itemBuilder,
        sourceList: widget.sourceList,
        padding: const EdgeInsets.all(5.0),
        lastChildLayoutType: LastChildLayoutType.foot,
      ),
    );
  }
}
