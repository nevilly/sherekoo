import 'package:flutter/material.dart';
import 'package:sherekoo/widgets/liveTabB.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/allData.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../../widgets/liveTabA.dart';

class Livee extends StatefulWidget {
  final CeremonyModel ceremony;
  const Livee({Key? key, required this.ceremony}) : super(key: key);

  @override
  State<Livee> createState() => _LiveeState();
}

class _LiveeState extends State<Livee> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Preferences _preferences = Preferences();

  String token = '';
  static String myVideoId = 'kPnKhtlGWV4';
  User currentUser = User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '', isCurrentUser: '', address: '', bio: '', meritalStatus: '');

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: myVideoId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

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
        getUser();
      });
    });

    super.initState();
  }

  getUser() async {
    AllUsersModel(payload: [], status: 0).get(token, urlGetUser).then((value) {
      setState(() {
        currentUser = User.fromJson(value.payload);
      });
    });
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
                  child: YoutubePlayer(
                      controller: _controller, liveUIColor: Colors.amber)),

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
            TabA(
              ceremony: widget.ceremony,
              getcurrentUser: currentUser.id,
            ),
            TabB(
              ceremony: widget.ceremony,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
