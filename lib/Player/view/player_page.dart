import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:streaming_app/data/service/storage_services.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({
    Key? key,
    required this.videoId,
    required this.videoURL,
  }) : super(key: key);

  final int videoId;
  final String videoURL;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  Duration _reStoreLastPosition() {
    final playbackValue = UserSimplePreferences.getPlaybackValue(widget.videoId);
    if (playbackValue == null) {
      return Duration.zero;
    } else {
      return Duration(milliseconds: playbackValue);
    }
  }

  void _initVideoPlayer() async {
    videoPlayerController = VideoPlayerController.asset(widget.videoURL);
    await videoPlayerController.initialize().then((value) => {
          videoPlayerController.addListener(() {
            UserSimplePreferences.setPlaybackValue(
                videoPlayerController.value.position.inMilliseconds, widget.videoId);
          })
        });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      allowedScreenSleep: false,
      allowFullScreen: true,
      showControls: true,
      startAt: _reStoreLastPosition(),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chewieController != null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Chewie(
                controller: chewieController!,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
