import 'dart:ui';

/// Abstract class to define a drawable object.
abstract class Drawable {
  /// Whether the drawable is hidden or not.
  final bool hidden;
  final double opacity;

  /// Default constructor.
  const Drawable({this.hidden = false, this.opacity = 1});

  /// Draws the drawable on the provided [canvas] of size [size].
  void draw(Canvas canvas, Size size, [double opactiy = 1]);

  bool get isHidden => hidden;

  bool get isNotHidden => !hidden;

  /// callback when tab the drawable on the provided [canvas] of size [size].
  void onTapped();

  /// Checks equality between two [Drawable]s.
  // @override
  // bool operator ==(Object other) {
  //   return other is Drawable && other.hidden == hidden;
  // }
  //
  // @override
  // int get hashCode {
  //   return hidden.hashCode;
  // }
}
