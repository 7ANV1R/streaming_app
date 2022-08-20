import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:streaming_app/Player/view/player_page.dart';
import 'package:streaming_app/core/ui_helper.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    Key? key,
    required this.size,
    required this.videos,
    required this.textTheme,
    required this.index,
  }) : super(key: key);

  final Size size;
  final List videos;
  final TextTheme textTheme;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log(videos[index]['title']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerPage(
              videoURL: videos[index]['videoPath'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: size.width / 2,
                    width: size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.darken),
                        image: AssetImage(
                          videos[index]['thumbnail'],
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                    size: 48,
                  ),
                ],
              ),
            ),
            kVerticalSpaceS,
            Text(
              videos[index]['title'],
              style: textTheme.headline6,
            ),
            Row(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.thumb_up,
                      size: 16,
                    ),
                    kHorizontalSpaceXS,
                    Text(
                      '865 likes',
                      style: textTheme.bodyText2,
                    ),
                  ],
                ),
                kHorizontalSpaceS,
                Row(
                  children: [
                    const Icon(
                      Icons.visibility,
                      size: 16,
                    ),
                    kHorizontalSpaceXS,
                    Text(
                      '1200 views',
                      style: textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
