import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({
    Key? key,
    required this.videoURL,
  }) : super(key: key);

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

  void _checkVideo() {
    if (videoPlayerController.value.position == const Duration(seconds: 0, minutes: 0, hours: 0)) {
      log('video Started');
      videoPlayerController.pause();
    }

    if (videoPlayerController.value.position == videoPlayerController.value.duration) {
      log('video Ended');
    }
  }

  void _initVideoPlayer() async {
    videoPlayerController = VideoPlayerController.asset(widget.videoURL);
    await videoPlayerController.initialize().then((value) => {
          // videoPlayerController.addListener(() {
          //   setState(() {
          //     log(videoPlayerController.value.position.inSeconds.toString());
          //     if (videoPlayerController.value.isInitialized &&
          //         videoPlayerController.value.position.inSeconds == 20) {
          //       if (videoPlayerController.value.isPlaying) {
          //         videoPlayerController.pause();
          //       }
          //     }
          //   });
          // })
        });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      allowedScreenSleep: false,
      allowFullScreen: true,
      showControls: true,
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
