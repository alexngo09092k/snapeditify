import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' as vp;

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    super.key,
    required this.videoURL,
  });

  final String videoURL;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  vp.VideoPlayerController? _videoController;

  bool _isInitializing = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideo(widget.videoURL);
  }

  Future<void> _initializeVideo(String url) async {
    final controller = vp.VideoPlayerController.networkUrl(
      Uri.parse(url),
    );

    _videoController = controller;

    try {
      await controller.initialize();

      // Controller có thể đã bị thay thế nếu URL thay đổi.
      if (!mounted || !identical(_videoController, controller)) {
        await controller.dispose();
        return;
      }

      setState(() {
        _isInitializing = false;
        _errorMessage = null;
      });
    } catch (error) {
      if (!identical(_videoController, controller)) {
        await controller.dispose();
        return;
      }

      await controller.dispose();

      if (!mounted) return;

      setState(() {
        _videoController = null;
        _isInitializing = false;
        _errorMessage = 'Unable to load video.';
      });

      debugPrint('Video initialization error: $error');
    }
  }

  @override
  void didUpdateWidget(covariant VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoURL != widget.videoURL) {
      final oldController = _videoController;

      _videoController = null;
      _isInitializing = true;
      _errorMessage = null;

      oldController?.dispose();

      _initializeVideo(widget.videoURL);
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    final controller = _videoController;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (controller.value.isPlaying) {
      await controller.pause();
    } else {
      if (controller.value.position >= controller.value.duration) {
        await controller.seekTo(Duration.zero);
      }

      await controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(_errorMessage!),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isInitializing = true;
                    _errorMessage = null;
                  });

                  _initializeVideo(widget.videoURL);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final controller = _videoController;

    if (controller == null || !controller.value.isInitialized) {
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio > 0
          ? controller.value.aspectRatio
          : 16 / 9,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Video content
          vp.VideoPlayer(controller),

          // Tap video to play / pause
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _togglePlayPause,
              child: const SizedBox.expand(),
            ),
          ),

          // Play / Pause button
          ValueListenableBuilder<vp.VideoPlayerValue>(
            valueListenable: controller,
            builder: (context, value, child) {
              return AnimatedOpacity(
                opacity: value.isPlaying ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _togglePlayPause,
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              );
            },
          ),

          // Bottom controls
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              color: Colors.black45,
              child: Row(
                children: [
                  ValueListenableBuilder<vp.VideoPlayerValue>(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      return IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: _togglePlayPause,
                        icon: Icon(
                          value.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: vp.VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      colors: const vp.VideoProgressColors(
                        playedColor: Colors.red,
                        bufferedColor: Colors.white54,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
