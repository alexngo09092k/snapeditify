import 'dart:ui' as ui;

class ImageDrawer {
  ui.Image image;
  ui.Offset? position;
  ui.Size? size;
  bool locked;
  Function(ui.Offset)? onTap;

  ImageDrawer({
    required this.image,
    this.position,
    this.size,
    this.locked = false,
    this.onTap,
  });
}
