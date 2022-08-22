import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:streaming_app/core/ui_helper.dart';
import 'package:streaming_app/data/service/storage_services.dart';

class StatsCard extends StatefulWidget {
  const StatsCard({
    Key? key,
    required this.videos,
    required this.index,
  }) : super(key: key);

  final List videos;
  final int index;

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  int _likeCount() {
    var currentlikeCount = UserSimplePreferences.getLikeStatsValue(widget.videos[widget.index]['id']);
    if (currentlikeCount == null) {
      return 0;
    } else {
      return currentlikeCount;
    }
  }

  int _dislikeCount() {
    var currentDislikeCount = UserSimplePreferences.getDislikeStatsValue(widget.videos[widget.index]['id']);
    if (currentDislikeCount == null) {
      return 0;
    } else {
      return currentDislikeCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    int likeCount = _likeCount();
    int dislikeCount = _dislikeCount();
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.videos[widget.index]['thumbnail'],
                ),
              ),
            ),
          ),
          kHorizontalSpaceM,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpaceXS,
              Text(
                widget.videos[widget.index]['title'],
              ),
              kVerticalSpaceS,
              LinearPercentIndicator(
                leading: const Icon(
                  Icons.thumb_up_alt_rounded,
                  size: 16,
                  color: Colors.purple,
                ),
                trailing: const Icon(
                  Icons.thumb_down_alt_rounded,
                  color: Colors.grey,
                  size: 16,
                ),
                animation: true,
                width: 140.0,
                lineHeight: 8.0,
                percent: (likeCount + dislikeCount) == 0
                    ? 0.5
                    : likeCount / (likeCount + dislikeCount), // like/total
                backgroundColor: Colors.grey,
                progressColor: Colors.purple,
                barRadius: const Radius.circular(16),
                animationDuration: 800,
              ),
              kVerticalSpaceS,
              Text(
                '$likeCount Likes\n$dislikeCount Dislikes',
                style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
