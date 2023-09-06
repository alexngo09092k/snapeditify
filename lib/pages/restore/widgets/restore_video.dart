import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/providers/restore/restore_provider.dart';
import 'package:snapeditify/widgets/app_use/video_player.dart';

class RestoreVideo extends StatefulWidget {
  const RestoreVideo({super.key});

  @override
  State<RestoreVideo> createState() => _RestoreVideoState();
}

class _RestoreVideoState extends ProviderStateObserver<RestoreVideo, IRestoreProvider> {
  @override
  void onNextFrame(Duration timestamp) {
    provider.videoEffect(context);
    super.onNextFrame(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: PropConsumer<IRestoreProvider, double>(
              select: (p) => p.state.image.ratio,
              child: PropConsumer<RestoreProvider, String?>(
                select: (_) => _.state.videoURL,
                builder: (_, __, ___, videoURL) {
                  if (videoURL == null) return const SizedBox();
                  return VideoPlayer(
                    videoURL: videoURL,
                  );
                },
              ),
              builder: (_, child, __, ratio) => AspectRatio(
                aspectRatio: ratio,
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}