import 'package:flutter/material.dart';
import 'package:streaming_app/Stats/widgets/stats_card.dart';
import 'package:streaming_app/core/ui_helper.dart';
import 'package:streaming_app/data/temp_data.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    List videos = videoData;

    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 48.0),
            child: RichText(
              text: TextSpan(
                text: 'video\n',
                style: textTheme.headline6,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Statistics',
                    style: textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
          kVerticalSpaceM,

          //background
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
                color: Colors.purple[50],
              ),
              //content clip
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return StatsCard(videos: videos, index: index);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
