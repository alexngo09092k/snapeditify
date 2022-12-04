// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

class SourceList<T> extends LoadingMoreBase<T> {
  SourceList({this.maxLength = 300, required this.loadMoreData});

  final int maxLength;
  Future<List<T>> Function(int page, bool isloadMoreAction) loadMoreData;

  // INIT STATE
  int _pageIndex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;

  @override
  bool get hasMore => (_hasMore && length < maxLength) || forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    _pageIndex = 1;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !notifyStateChanged;
    final bool result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    bool isSuccess = false;
    try {
      //to show loading more clearly, in your app,remove this
      //await Future<void>.delayed(const Duration(seconds: 5));
      List<T>? data = await loadMoreData(_pageIndex, isloadMoreAction);

      if (_pageIndex == 1) {
        clear();
      }

      addAll(data);

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
  final SourceList<T> sourceList;
  final Widget Function(BuildContext)? headerBuilder;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final SliverGridDelegate? gridDelegate;
  final ExtendedListDelegate? extendedListDelegate;
  final EdgeInsetsGeometry? padding;

  MultipleSliverSourceList({
    required this.sourceList,
    this.headerBuilder,
    required this.itemBuilder,
    this.gridDelegate,
    this.extendedListDelegate,
    this.padding,
  });
}
