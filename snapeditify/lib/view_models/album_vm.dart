// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:photo_manager/photo_manager.dart';

class AlbumVM {
  final AssetPathEntity entityPath;
  final AssetEntity? thumnail;
  final int count;

  const AlbumVM({
    required this.entityPath,
    this.thumnail,
    this.count = 0,
  });
}
