import 'package:flutter/material.dart';
import 'package:sherekoo/widgets/liveTabB.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/ceremony/ceremonyModel.dart';
import '../../util/Preferences.dart';
import '../../widgets/liveTabA.dart';

class Livee extends StatefulWidget {
  final CeremonyModel ceremony;
  const Livee({Key? key, required this.ceremony}) : super(key: key);

  @override
  State<Livee> createState() => _LiveeState();
}

class _LiveeState extends State<Livee> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late YoutubePlayerController _controller;
  final Preferences _preferences = Preferences();

  String token = '';
  // static String myVideoId = '';

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );

    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
      });
    });
    if (widget.ceremony.youtubeLink != 'GoLive') {
      loadYOutube(widget.ceremony.youtubeLink);
    }

    super.initState();
  }

  loadYOutube(String url) {
    _controller = YoutubePlayerController(
      initialVideoId: url,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black45,
              // automaticallyImplyLeading: false,
              expandedHeight: 200,
              flexibleSpace: SafeArea(
                  bottom: false,
                  child: Expanded(
                    flex: 5,
                    child: widget.ceremony.youtubeLink != 'GoLive'
                        ? YoutubePlayer(
                            controller: _controller, liveUIColor: Colors.amber)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Ceremony Loading',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                  )),

              pinned: true,
              floating: true,
              bottom: TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.white,
                  labelPadding: const EdgeInsets.only(
                    bottom: 2,
                  ),
                  indicatorPadding: const EdgeInsets.only(
                    top: 10,
                  ),
                  controller: _tabController,
                  tabs: const [
                    Text("Posts"),
                    Text("Details"),
                  ]),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            Expanded(
              flex: 2,
              child: TabA(
                ceremony: widget.ceremony,
              ),
            ),
            Expanded(
                flex: 2,
                child: TabB(
                  ceremony: widget.ceremony,
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
