import 'package:flutter/material.dart';
import 'package:snapeditify/pages/restore/widgets/restore_image.dart';

/// Tạm ẩn tạo video (chưa support).
/// Khi bật lại: restore file từ git / đặt kRestoreVideoEnabled = true
/// và khôi phục PageView + SlidingControl + RestoreVideo.
const bool kRestoreVideoEnabled = false;

class RestoreTabs extends StatelessWidget {
  const RestoreTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Chỉ hiện restore ảnh
    return const Expanded(
      child: RestoreImage(),
    );
  }
}
