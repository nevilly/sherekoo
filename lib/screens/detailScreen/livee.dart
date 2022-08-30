import 'package:flutter/material.dart';
import 'package:sherekoo/widgets/liveTabB.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/allData.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../../widgets/liveTabA.dart';
import '../uploadScreens/uploadSherekoo.dart';

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
  int tabIndex = 0;
  // static String myVideoId = '';

  User currentUser = User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      isCurrentUser: '',
      address: '',
      bio: '',
      meritalStatus: '');

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
    if (widget.ceremony.youtubeLink != 'GoLive') {
      loadYOutube(widget.ceremony.youtubeLink);
    }

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          tabIndex = _tabController.index;
          // print('is changing index');
          // print(_tabController.index);
          // _tabController.
        });
      }
      if (_tabController.animation != null) {
        setState(() {
          tabIndex = _tabController.animation!.value.floor();
          _tabController.animation;
          print('is animate index');
          print(_tabController.animation!.value.floor());
        });
      }
    });
    super.initState();
  }

  getUser() async {
    AllUsersModel(payload: [], status: 0).get(token, urlGetUser).then((value) {
      if (value.status == 200) {
        setState(() {
          currentUser = User.fromJson(value.payload);
        });
      }
    });
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
      backgroundColor: OColors.secondary,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: OColors.secondary,
              // automaticallyImplyLeading: false,
              expandedHeight: 200,
              flexibleSpace: SafeArea(
                  bottom: false,
                  child: Expanded(
                    flex: 5,
                    child: widget.ceremony.youtubeLink != 'GoLive'
                        ? YoutubePlayer(
                            controller: _controller,
                            liveUIColor: OColors.primary)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Ceremony Loading',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                  )),

              pinned: true,
              floating: true,
              bottom: TabBar(
                  labelColor: OColors.primary,
                  indicatorColor: OColors.primary,
                  // unselectedLabelColor: OColors.darkGrey,
                  labelPadding: const EdgeInsets.only(
                    bottom: 2,
                  ),
                  indicatorPadding: const EdgeInsets.only(
                    top: 10,
                  ),
                  controller: _tabController,
                  tabs: [
                    Icon(
                      Icons.grid_on_outlined,
                      size: 20,
                      color: OColors.primary,
                    ),
                    Icon(
                      Icons.details,
                      size: 20,
                      color: OColors.primary,
                    )
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
                user: currentUser,
              ),
            ),
            Expanded(
                flex: 2,
                child: TabB(
                  ceremony: widget.ceremony,
                  user: currentUser,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SherekooUpload(
                        crm: widget.ceremony,
                        from: 'Ceremony',
                      )));
        },
        splashColor: Colors.yellow,

        // icon: const Icon(Icons.upload, color: Colors.white),
        label: tabIndex == 0
            ? const Text('post')
            : tabIndex == 1 && currentUser.id == widget.ceremony.admin ||
                    currentUser.id == widget.ceremony.fId
                ? const Text('Choose')
                : const Text('Post'),
        backgroundColor: Colors.red,
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
