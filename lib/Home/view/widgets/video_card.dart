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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerPage(
              videoId: videos[index]['id'],
              videoURL: videos[index]['videoPath'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kVerticalSpaceM,
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
                        image: NetworkImage(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Posted 1 years ago",
                    style: textTheme.bodyText2,
                  ),
                ),
                // view
                Row(
                  children: [
                    const Icon(
                      Icons.visibility,
                      size: 16,
                    ),
                    kHorizontalSpaceXS,
                    Text(
                      '97k views',
                      style: textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
            kVerticalSpaceL,
            Container(
              height: 1,
              color: Colors.black12,
            )
          ],
        ),
      ),
    );
  }
}
