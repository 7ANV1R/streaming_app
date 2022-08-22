import 'dart:async';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:streaming_app/data/service/storage_services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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

  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    String localUrl;
    if (!url.contains('http') && (url.length == 11)) return url;
    if (trimWhitespaces) {
      localUrl = url.trim();
    } else {
      localUrl = url;
    }

    for (final exp in [
      RegExp(r'^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$'),
      RegExp(r'^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$'),
      RegExp(r'^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$')
    ]) {
      final RegExpMatch? match = exp.firstMatch(localUrl);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  Future<String> _extractVideoUrl() async {
    final extractor = YoutubeExplode();
    final videoId = convertUrlToId(widget.videoURL);
    final streamManifest = await extractor.videos.streamsClient.getManifest(videoId);
    final streamInfo = streamManifest.muxed.withHighestBitrate();
    extractor.close();
    return streamInfo.url.toString();
  }

  Duration _reStoreLastPosition() {
    final playbackValue = UserSimplePreferences.getPlaybackValue(widget.videoId);
    if (playbackValue == null) {
      return Duration.zero;
    } else {
      return Duration(seconds: playbackValue);
    }
  }

  void _incrementLike() {
    var currentLikeCount = UserSimplePreferences.getLikeStatsValue(widget.videoId);
    if (currentLikeCount == null) {
      UserSimplePreferences.setLikeStatsValue(1, widget.videoId);
    } else {
      UserSimplePreferences.setLikeStatsValue(currentLikeCount + 1, widget.videoId);
    }
  }

  void _incrementDislike() {
    var currentDislikeCount = UserSimplePreferences.getDislikeStatsValue(widget.videoId);
    if (currentDislikeCount == null) {
      UserSimplePreferences.setDislikeStatsValue(1, widget.videoId);
    } else {
      UserSimplePreferences.setDislikeStatsValue(currentDislikeCount + 1, widget.videoId);
    }
  }

  void _initVideoPlayer() async {
    var url = await _extractVideoUrl();
    String lastLoggedTime = ""; //for avoiding multiple listening

    videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController.initialize().then((value) => {
          videoPlayerController.addListener(
            () {
              //for avoiding multiple listening
              if (lastLoggedTime != videoPlayerController.value.position.inSeconds.toString()) {
                lastLoggedTime = videoPlayerController.value.position.inSeconds.toString(); //<--save it here

                UserSimplePreferences.setPlaybackValue(
                    videoPlayerController.value.position.inSeconds, widget.videoId);
                if (lastLoggedTime == 60.toString()) {
                  videoPlayerController.pause();
                  openDialog();
                }
              }
            },
          )
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

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Do you like this video?'),
          actions: [
            TextButton(
              onPressed: () {
                _incrementLike();
                log('liked');
                Navigator.of(context).pop();
                videoPlayerController.play();
                setState(() {});
              },
              child: const Text('YES'),
            ),
            TextButton(
              onPressed: () {
                _incrementDislike();
                log('disliked');
                Navigator.of(context).pop();
                videoPlayerController.play();
                setState(() {});
              },
              child: const Text('NO'),
            ),
          ],
        ),
      );
}
