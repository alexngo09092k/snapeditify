import 'dart:convert';

import 'package:photo_manager/photo_manager.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GalleryConfig {
  final bool hasAll;
  final bool onlyAll;

  final int countInPage;

  /// Options
  final int minWidth;
  final int maxWidth;
  final int minHeight;
  final int maxHeight;
  final bool ignoreSize;

  final Duration minDuration;
  final Duration maxDuration;

  final bool needTitle;

  final bool containsPathModified;
  final bool containsLivePhotos;
  final bool onlyLivePhotos;

  GalleryConfig({
    required this.countInPage,
    required this.hasAll,
    required this.onlyAll,
    required this.minWidth,
    required this.maxWidth,
    required this.minHeight,
    required this.maxHeight,
    required this.ignoreSize,
    required this.minDuration,
    required this.maxDuration,
    required this.needTitle,
    required this.containsPathModified,
    required this.containsLivePhotos,
    required this.onlyLivePhotos,
  });

  factory GalleryConfig.defaultValue() {
    return GalleryConfig(
      countInPage: 50,
      hasAll: true,
      onlyAll: false,
      minWidth: 0,
      maxWidth: 100000,
      minHeight: 0,
      maxHeight: 100000,
      ignoreSize: true,
      minDuration: Duration.zero,
      maxDuration: const Duration(milliseconds: 60 * 60 * 1000),
      needTitle: false,
      containsLivePhotos: true,
      containsPathModified: false,
      onlyLivePhotos: false,
    );
  }

  FilterOptionGroup get option {
    final FilterOption option = FilterOption(
      sizeConstraint: SizeConstraint(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        ignoreSize: ignoreSize,
      ),
      durationConstraint: DurationConstraint(
        min: minDuration,
        max: maxDuration,
      ),
      needTitle: needTitle,
    );

    return FilterOptionGroup()
      ..setOption(AssetType.video, option)
      ..setOption(AssetType.image, option)
      ..setOption(AssetType.audio, option)
      ..containsPathModified = containsPathModified
      ..containsLivePhotos = containsLivePhotos
      ..onlyLivePhotos = onlyLivePhotos;
  }

  GalleryConfig copyWith({
    int? countInPage,
    bool? hasAll,
    bool? onlyAll,
    int? minWidth,
    int? maxWidth,
    int? minHeight,
    int? maxHeight,
    bool? ignoreSize,
    Duration? minDuration,
    Duration? maxDuration,
    bool? needTitle,
    bool? containsPathModified,
    bool? containsLivePhotos,
    bool? onlyLivePhotos,
  }) {
    return GalleryConfig(
      countInPage: countInPage ?? this.countInPage,
      hasAll: hasAll ?? this.hasAll,
      onlyAll: onlyAll ?? this.onlyAll,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      ignoreSize: ignoreSize ?? this.ignoreSize,
      minDuration: minDuration ?? this.minDuration,
      maxDuration: maxDuration ?? this.maxDuration,
      needTitle: needTitle ?? this.needTitle,
      containsPathModified: containsPathModified ?? this.containsPathModified,
      containsLivePhotos: containsLivePhotos ?? this.containsLivePhotos,
      onlyLivePhotos: onlyLivePhotos ?? this.onlyLivePhotos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countInPage': countInPage,
      'hasAll': hasAll,
      'onlyAll': onlyAll,
      'minWidth': minWidth,
      'maxWidth': maxWidth,
      'minHeight': minHeight,
      'maxHeight': maxHeight,
      'ignoreSize': ignoreSize,
      'minDuration': minDuration.inMilliseconds,
      'maxDuration': maxDuration.inMilliseconds,
      'needTitle': needTitle,
      'containsPathModified': containsPathModified,
      'containsLivePhotos': containsLivePhotos,
      'onlyLivePhotos': onlyLivePhotos,
    };
  }

  factory GalleryConfig.fromMap(Map<String, dynamic> map) {
    return GalleryConfig.defaultValue().copyWith(
      countInPage: map['countInPage'],
      hasAll: map['hasAll'],
      onlyAll: map['onlyAll'],
      minWidth: map['minWidth'],
      maxWidth: map['maxWidth'],
      minHeight: map['minHeight'],
      maxHeight: map['maxHeight'],
      ignoreSize: map['ignoreSize'],
      minDuration: map['minDuration'] != null ? Duration(milliseconds: map['minDuration']) : null,
      maxDuration: map['maxDuration'] != null ? Duration(milliseconds: map['maxDuration']) : null,
      needTitle: map['needTitle'],
      containsPathModified: map['containsPathModified'],
      containsLivePhotos: map['containsLivePhotos'],
      onlyLivePhotos: map['onlyLivePhotos'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GalleryConfig.fromJson(String source) => GalleryConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GalleryConfig(countInPage: $countInPage, hasAll: $hasAll, onlyAll: $onlyAll, minWidth: $minWidth, maxWidth: $maxWidth, minHeight: $minHeight, maxHeight: $maxHeight, ignoreSize: $ignoreSize, minDuration: $minDuration, maxDuration: $maxDuration, needTitle: $needTitle, containsPathModified: $containsPathModified, containsLivePhotos: $containsLivePhotos, onlyLivePhotos: $onlyLivePhotos)';
  }

  @override
  bool operator ==(covariant GalleryConfig other) {
    if (identical(this, other)) return true;

    return other.countInPage == countInPage &&
        other.hasAll == hasAll &&
        other.onlyAll == onlyAll &&
        other.minWidth == minWidth &&
        other.maxWidth == maxWidth &&
        other.minHeight == minHeight &&
        other.maxHeight == maxHeight &&
        other.ignoreSize == ignoreSize &&
        other.minDuration == minDuration &&
        other.maxDuration == maxDuration &&
        other.needTitle == needTitle &&
        other.containsPathModified == containsPathModified &&
        other.containsLivePhotos == containsLivePhotos &&
        other.onlyLivePhotos == onlyLivePhotos;
  }

  @override
  int get hashCode {
    return countInPage.hashCode ^
        hasAll.hashCode ^
        onlyAll.hashCode ^
        minWidth.hashCode ^
        maxWidth.hashCode ^
        minHeight.hashCode ^
        maxHeight.hashCode ^
        ignoreSize.hashCode ^
        minDuration.hashCode ^
        maxDuration.hashCode ^
        needTitle.hashCode ^
        containsPathModified.hashCode ^
        containsLivePhotos.hashCode ^
        onlyLivePhotos.hashCode;
  }
}
