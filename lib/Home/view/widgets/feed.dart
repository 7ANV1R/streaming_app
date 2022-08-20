import 'package:flutter/material.dart';
import 'package:streaming_app/Home/view/widgets/video_card.dart';
import 'package:streaming_app/data/temp_data.dart';

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
  }) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    List videos = videoData;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: VideoCard(size: size, videos: videos, textTheme: textTheme, index: index),
        );
      },
    );
  }
}
