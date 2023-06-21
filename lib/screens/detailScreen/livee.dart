import 'package:flutter/material.dart';
import 'package:sherekoo/widgets/liveTabB.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/post/sherekoModel.dart';
import '../../model/user/user-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/liveTabA.dart';
import '../admin/crmAdmin.dart';
import '../uploadScreens/uploadSherekoo.dart';
import 'package:sherekoo/model/ceremony/crmVwr-model.dart';

class Livee extends StatefulWidget {
  final CeremonyModel ceremony;
  const Livee({Key? key, required this.ceremony}) : super(key: key);

  @override
  State<Livee> createState() => _LiveeState();
}

class _LiveeState extends State<Livee> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late YoutubePlayerController? _controller;

  int tabIndex = 0;
  // static String myVideoId = '';

  ScrollController? _cntr;

  User user = User(
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
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');

  CrmViewersModel crmCwr = CrmViewersModel(
      id: '',
      userId: '',
      name: '',
      contact: '',
      position: '',
      crmInfo: emptyCrmModel,
      viewerInfo: emptyUser,
      isAdmin: '',
      crmId: '',
      mchangoInfo: emptyMchango);
  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    // print('whats null');
    // print(widget.ceremony.fId);
    // print(widget.ceremony.sId);
    // print('widget.ceremony.admin');
    // print(widget.ceremony.ceremonyType);

    preferences.init();
    preferences.get('token').then((value) {
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
        });
      }
      if (_tabController.animation != null) {
        setState(() {
          tabIndex = _tabController.animation!.value.floor();
          _tabController.animation;
        });
      }
    });
    super.initState();
  }

  getUser() async {
    UsersCall(payload: [], status: 0).get(token, urlGetUser).then((value) {
      if (value.status == 200) {
        setState(() {
          user = User.fromJson(value.payload);
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
        controller: _cntr,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: OColors.darGrey,
              // automaticallyImplyLeading: false,
              actions: [
                if (widget.ceremony.isCrmAdmin == 'true')
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CrmnAdmin(
                                    crm: widget.ceremony,
                                    user: user,
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 20, top: 15, bottom: 15),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 4, bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: OColors.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(80))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Text(
                            'Admin',
                            style:
                                header11.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () {
                      paymentMethod(context, crmCwr, user);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 20, top: 15, bottom: 15),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 4, bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: OColors.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(80))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Text(
                            'Contribution',
                            style:
                                header11.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
              expandedHeight: 200,
              flexibleSpace: SafeArea(
                  bottom: false,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      widget.ceremony.youtubeLink != 'GoLive'
                          ? YoutubePlayer(
                              controller: _controller!,
                              liveUIColor: OColors.primary)
                          : Center(
                              child: Text(
                                'Ceremony Loading',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: OColors.fontColor),
                              ),
                            )
                    ],
                  )),

              pinned: true,
              floating: false,
              bottom: TabBar(
                  labelColor: OColors.primary,
                  indicatorColor: OColors.primary,
                  unselectedLabelColor: OColors.primary,
                  labelPadding: const EdgeInsets.only(
                    bottom: 2,
                  ),
                  indicatorPadding: const EdgeInsets.only(
                    top: 25,
                  ),
                  controller: _tabController,
                  tabs: [
                    Text('Posts', style: header16),
                    // Icon(
                    //   Icons.grid_on_outlined,
                    //   size: 20,
                    //   color: OColors.primary,
                    // ),
                    Text('Details', style: header16),
                    // Icon(
                    //   Icons.details,
                    //   size: 20,
                    //   color: OColors.primary,
                    // )
                  ]),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            TabA(
              ceremony: widget.ceremony,
              user: user,
            ),
            TabB(
              ceremony: widget.ceremony,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (tabIndex == 0) {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SherekooUpload(
                          crm: widget.ceremony,
                          from: 'Ceremony',
                          post: SherekooModel(
                              pId: '',
                              createdBy: '',
                              ceremonyId: '',
                              body: '',
                              vedeo: '',
                              mediaUrl: '',
                              creatorInfo: User(
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
                                  meritalStatus: '',
                                  totalPost: '',
                                  isCurrentBsnAdmin: '',
                                  isCurrentCrmAdmin: '',
                                  totalFollowers: '',
                                  totalFollowing: '',
                                  totalLikes: ''),
                              createdDate: '',
                              commentNumber: '',
                              crmInfo: CeremonyModel(
                                cId: '',
                                codeNo: '',
                                ceremonyType: '',
                                cName: '',
                                fId: '',
                                sId: '',
                                cImage: '',
                                ceremonyDate: '',
                                admin: '',
                                contact: '',
                                isInFuture: '',
                                isCrmAdmin: '',
                                likeNo: '',
                                chatNo: '',
                                viwersNo: '',
                                userFid: emptyUser,
                                userSid: emptyUser,
                                youtubeLink: '',
                              ),
                              totalLikes: '',
                              isLike: '',
                              totalShare: '',
                              hashTag: '',
                              isPostAdmin: false,
                              crmViewer: '',
                              waterMarklUrl: ''),
                        )));
          }

          if (tabIndex != 1 && user.id != widget.ceremony.admin ||
              user.id == widget.ceremony.fId) {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SherekooUpload(
                          crm: widget.ceremony,
                          from: 'Ceremony',
                          post: SherekooModel(
                              pId: '',
                              createdBy: '',
                              ceremonyId: '',
                              body: '',
                              vedeo: '',
                              mediaUrl: '',
                              creatorInfo: User(
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
                                  meritalStatus: '',
                                  totalPost: '',
                                  isCurrentBsnAdmin: '',
                                  isCurrentCrmAdmin: '',
                                  totalFollowers: '',
                                  totalFollowing: '',
                                  totalLikes: ''),
                              createdDate: '',
                              commentNumber: '',
                              crmInfo: CeremonyModel(
                                cId: '',
                                codeNo: '',
                                ceremonyType: '',
                                cName: '',
                                fId: '',
                                sId: '',
                                cImage: '',
                                ceremonyDate: '',
                                admin: '',
                                contact: '',
                                isInFuture: '',
                                isCrmAdmin: '',
                                likeNo: '',
                                chatNo: '',
                                viwersNo: '',
                                userFid: emptyUser,
                                userSid: emptyUser,
                                youtubeLink: '',
                              ),
                              totalLikes: '',
                              isLike: '',
                              totalShare: '',
                              hashTag: '',
                              isPostAdmin: false,
                              crmViewer: '',
                              waterMarklUrl: ''),
                        )));
          }
        },
        // splashColor: Colors.yellow,

        // icon: const Icon(Icons.upload, color: Colors.white),
        label: tabIndex == 0
            ? const Text('post')
            : tabIndex == 1 && user.id == widget.ceremony.admin ||
                    user.id == widget.ceremony.fId
                ? const Text('Choose')
                : const Text('Post'),
        backgroundColor: OColors.primary,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();

    if (!mounted) {
      _controller!.dispose();
    }

    super.dispose();
  }
}
