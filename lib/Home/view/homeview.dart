import 'package:flutter/material.dart';
import 'package:streaming_app/Home/view/widgets/feed.dart';
import 'package:streaming_app/Stats/stats_page.dart';
import 'package:streaming_app/core/ui_helper.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo_400x400.png',
          height: size.height * 0.12,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_outlined,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.face,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Let\'s\n',
                    style: textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Discover',
                        style: textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StatsPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.insights,
                  ),
                ),
              ],
            ),
          ),
          kVerticalSpaceM,
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                  color: Colors.purple[100],
                ),
                child: const ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                  child: Feed(),
                )),
          ),
        ],
      ),
    );
  }
}
