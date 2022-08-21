import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:streaming_app/core/ui_helper.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    Key? key,
    required this.videos,
    required this.index,
  }) : super(key: key);

  final List videos;
  final int index;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
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
                image: AssetImage(
                  videos[index]['thumbnail'],
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
                videos[index]['title'],
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
                percent: 0.75,
                backgroundColor: Colors.grey,
                progressColor: Colors.purple,
                barRadius: const Radius.circular(16),
                animationDuration: 800,
              ),
              kVerticalSpaceS,
              Text(
                '75 Likes\n25 Dislikes',
                style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
