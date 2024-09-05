
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key, required this.videoURL});
  final String videoURL;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late CachedVideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    videoPlayerController = CachedVideoPlayerController.network(widget.videoURL)
          ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
    super.initState();
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomVideoPlayer(
      customVideoPlayerController: _customVideoPlayerController,
    );
  }
}
