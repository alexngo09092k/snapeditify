// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

class SourceList<T> extends LoadingMoreBase<T> {
  SourceList({this.maxLength = 300, this.onRefresh, this.onLoadMore});

  final int maxLength;

  Future<void> Function(SourceList)? onRefresh;
  Future<List<T>> Function(SourceList, bool isloadMoreAction)? onLoadMore;

  // INIT STATE
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  bool _forceRefresh = false;
  bool get forceRefresh => _forceRefresh;

  bool _hasMore = true;
  @override
  bool get hasMore => (_hasMore && length < maxLength) || _forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    _pageIndex = 0;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    _forceRefresh = !notifyStateChanged;
    final bool result = await super.refresh(notifyStateChanged);
    _forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    if (onLoadMore == null) return false;

    bool isSuccess = false;
    try {
      List<T>? data = await onLoadMore!(this, isloadMoreAction);

      if (_pageIndex == 0) {
        clear();
      }

      for (final item in data) {
        if (!contains(item) && hasMore) {
          add(item);
        }
      }

      _hasMore = data.isNotEmpty;
      _pageIndex++;
      isSuccess = true;
    } catch (exception) {
      isSuccess = false;
    }
    return isSuccess;
  }
}

class MultipleSliverSourceList<T> {
  final SourceList<T>? sourceList;
  final Widget Function(BuildContext, MultipleSliverSourceList<T>)? headerBuilder;
  final Widget Function(BuildContext, T, int)? itemBuilder;
  final SliverGridDelegate? gridDelegate;
  final ExtendedListDelegate? extendedListDelegate;
  final EdgeInsetsGeometry? padding;

  MultipleSliverSourceList({
    this.sourceList,
    this.headerBuilder,
    this.itemBuilder,
    this.gridDelegate,
    this.extendedListDelegate,
    this.padding,
  });
}
