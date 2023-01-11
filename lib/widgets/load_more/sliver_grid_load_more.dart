// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:phosart/widgets/load_more/source_list.dart';

class SliverGridLoadMore<T> extends StatefulWidget {
  const SliverGridLoadMore({
    super.key,
    this.gridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 300.0,
      crossAxisSpacing: 3.0,
      mainAxisSpacing: 3.0,
    ),
    this.padding = EdgeInsets.zero,
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
  _SliverGridLoadMoreState<T> createState() => _SliverGridLoadMoreState<T>();
}

class _SliverGridLoadMoreState<T> extends State<SliverGridLoadMore<T>> {
  @override
  Widget build(BuildContext context) {
    return LoadingMoreCustomScrollView(
      showGlowLeading: false,
      slivers: <Widget>[
        LoadingMoreSliverList<T>(
          SliverListConfig<T>(
            itemBuilder: widget.itemBuilder,
            sourceList: widget.sourceList,
            gridDelegate: widget.gridDelegate,
            indicatorBuilder: widget.indicatorBuilder,
          ),
        ),
      ],
    );
  }
}
