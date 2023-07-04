part of '../extensions.dart';

class Range extends Iterable<int> {
  const Range(this.start, this.end) : assert(start <= end);
  const Range.fromLength(int length) : this(0, length - 1);

  final int start;
  final int end;

  @override
  int get length => end - start + 1;

  @override
  Iterator<int> get iterator => Iterable.generate(length, (i) => start + i).iterator;

  @override
  bool contains(Object? element) {
    if (element == null || element is! int) return false;
    return element >= start && element <= end;
  }

  @override
  String toString() => '[$start, $end]';
}

extension ListExtensions on List {
  Range get indices => Range.fromLength(length);
}
