import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sherekoo/model/bigMontTvShow/bigMonth-call.dart';
import '../../model/bigMontTvShow/bigMnth-Reg-Memb.dart';
import '../../model/bigMontTvShow/bigMonth-Model.dart';
import '../../model/chats/chatPost.dart';
import '../../model/chats/chatsModel.dart';
import '../../model/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../homNav.dart';

class BigMonthWall extends StatefulWidget {
  final User currentUser;
  final BigMonthModel show;
  const BigMonthWall({Key? key, required this.show, required this.currentUser})
      : super(key: key);

  @override
  State<BigMonthWall> createState() => _BigMonthWallState();
}

class _BigMonthWallState extends State<BigMonthWall>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // ScrollController? _scrollController;
  // final TextEditingController _contact = TextEditingController();
  // final TextEditingController _crmDate = TextEditingController();

  final TextEditingController _body = TextEditingController();
  final TextEditingController _edtChat = TextEditingController();
  int idpost = 0;

  int tabIndex = 0;

  List<BgMnthRegMembersModel> registered = [];
  String id = "";
  String title = '';
  String description = '';
  String season = '';
  String episode = '';
  String showImage = '';
  String dedline = '';
  String showDate = '';
  String judgesId = '';
  String superStarsId = '';
  String status = '';
  String isUserIdRegister = '';

  List<User> judgesInfo = [];
  List<User> superStarInfo = [];
  List<ChatsModel> chats = [];
  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {});

    backgroundTask();
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        id = widget.show.id;
        title = widget.show.title;
        season = widget.show.season;
        episode = widget.show.episode;
        description = widget.show.description;
        dedline = widget.show.dedline;
        showImage = widget.show.showImage;
        status = widget.show.status;
        isUserIdRegister = widget.show.isRegistered;
        showDate = widget.show.showDate;

        judgesInfo = widget.show.judgesInfo;
        superStarInfo = widget.show.superStarInfo;

        getRegistered(id, '1');
      });
    });

    // _scrollController!.addListener(() {
    //   _scrollController!.createScrollPosition(_tabController);
    //   print(_scrollController!.positions);
    // });
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

  backgroundTask() async {
    // print("Hello");
    getPost();
    Timer.periodic(const Duration(seconds: 4), getPosts);
  }

  getPosts(Timer timer) {
    // print("Hello World $idpost");
    getPost();
    idpost++;

    return timer;
  }

  getPost() async {
    // print(widget.show.id);
    PostAllChats(
      payload: [],
      status: 0,
      body: '',
      postId: widget.show.id,
      userId: '',
    ).get(token, urlBigMonthGetChats).then((value) {
      final v = value.payload;
      if (mounted) {
        if (v != 'No content') {
          setState(() {
            chats = value.payload
                .map<ChatsModel>((e) => ChatsModel.fromJson(e))
                .toList();
          });
        }
      }
    });
    idpost++;
  }

  getRegistered(id, isElected) {
    BigMonthShowCall(status: 0, payload: [])
        .getRegisteredMember(token, urlGetBiMonthWallMembers, id, isElected)
        .then((value) {
      final v = value.payload;

      // print(v);
      if (value.status == 200) {
        setState(() {
          registered = v
              .map<BgMnthRegMembersModel>(
                  (e) => BgMnthRegMembersModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  deletePost(BuildContext context, ChatsModel itm) {
    PostAllChats(
      payload: [],
      status: 0,
      body: '',
      postId: itm.id,
      userId: '',
    ).deleteChat(token, urlBigMonthRemoveChat).then((value) {
      // final v = value.payload;
      if (value.status == 200) {
        setState(() {
          chats.removeWhere((element) => element.id == itm.id);
          Navigator.of(context).pop();

          // print(v);
        });
      }
    });
  }

  updateChat(
      BuildContext context, ChatsModel itm, TextEditingController newBody) {
    if (newBody.text.isNotEmpty) {
      PostAllChats(
        payload: [],
        status: 0,
        body: newBody.text,
        postId: itm.id,
        userId: '',
      ).editChat(token, urlBigMOnthUpdateChat).then((value) {
        // final v = value.payload;
        if (value.status == 200) {
          setState(() {
            itm.body = newBody.text;
            Navigator.of(context).pop();
            
          });
        }
      });
    } else {
      errorAlertDialog(context, 'Empty', 'Update your Post Please..');
    }
  }

  likeUpdate(BuildContext context, ChatsModel itm) {
    String isLike = itm.likeInfo.isLike! == 'false' ? '0' : '1';

    PostAllChats(
      payload: [],
      status: 0,
      body: '',
      postId: itm.id,
      userId: '',
    ).updateLike(token, urlBigMonthAddLikes, isLike).then((value) {
      // final v = value.payload;

      if (isLike == '0') {
        setState(() {
          itm.likeInfo.isLike = 'true';
          int likeNo = int.parse(itm.likeInfo.number!) + 1;
          itm.likeInfo.number = likeNo.toString();
        });
      } else {
        setState(() {
          itm.likeInfo.isLike = 'false';
          int likeNo = int.parse(itm.likeInfo.number!) - 1;
          itm.likeInfo.number = likeNo.toString();
        });
      }
    });
  }

  Widget continueButton() {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      ),
      child: const Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  TabBar get _tabBar => TabBar(
          labelColor: OColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: OColors.primary,
          indicatorWeight: 2,
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'OverView',
            ),
            Tab(
              text: 'Saved By',
            ),
          ]);

  Future<void> post() async {
    if (_body.text != '') {
      PostAllChats(
        postId: widget.show.id,
        userId: '',
        body: _body.text,
        status: 0,
        payload: [],
      ).post(token, urlBigMonthPostChats).then((value) {
        setState(() {});
      });
    } else {
      fillTheBlanks(context, 'Type Something..', altSty, prmry);
    }
  }

  List gender = [
    "Hate Speech",
    "Harrashment or bullying",
    "Mislaeading information",
    "Ponography & nudity",
    "Violent & graphic contents",
    "Scams & Frauds",
    "Spam",
    "Dangerous organization/individuals",
    "Other"
  ];

  String select = "";
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: OColors.primary,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              // print(value);
              select = value!;
            });
          },
        ),
        Text(title, style: header13)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: OColors.secondary,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(




                backgroundColor: OColors.darGrey,
                // automaticallyImplyLeading: false,
                actions: actionBar(context, size),
                expandedHeight: 200,
                flexibleSpace: bundleImage(size),
                pinned: true,
                floating: false,
              ),
            ];
          },
          body: Column(
            children: [
              SizedBox(
                height: size.height / (25 * 10),
              ),
              PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.8))),
                  child: ColoredBox(
                    color: OColors.darGrey,
                    child: _tabBar,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    overViews(context, size),
                    seviceDetails(context, size),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> actionBar(BuildContext context, size) {
    return [];
  }



  SafeArea bundleImage(Size size) {
    return SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            showImage != ''
                ? ClipRect(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          urlBigShowImg + showImage,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset('assets/ceremony/uk1.jpg',
                        width: size.width, fit: BoxFit.cover),
                  ),
          ],
        ));
  }

  Scrollbar overViews(BuildContext context, size) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          // const SizedBox(height: 25),
          tvShowChats(),

          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 4.8,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: OColors.primary.withOpacity(.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Stack(
              children: [
                TextFormField(
                  controller: _body,
                  maxLines: null,
                  expands: true,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.multiline,
                  style: header13,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: OColors.white, fontSize: 12),

                    contentPadding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 1, bottom: 5),

                    prefixIcon:
                        Icon(Icons.tag_faces_sharp, color: OColors.primary),

                    suffixIcon: GestureDetector(
                        onTap: () {
                          post();
                          _body.text = '';
                        },
                        child: Icon(
                          Icons.send,
                          color: OColors.primary,
                          size: 20,
                        )),
                    // suffixIcon: Icon(Icons.send_rounded),
                    hintText: l(sw, 48),

                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: OColors.primary,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: OColors.primary,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: OColors.primary,
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Scrollbar seviceDetails(BuildContext context, size) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            //Judges
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Judges',
                style: header15,
              ),
            ),

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.show.judgesInfo.length,
                itemBuilder: (context, i) {
                  final itm = widget.show.judgesInfo[i];
                  final judgeAvater =
                      '${api}public/uploads/${itm.username!}/profile/${itm.avater!}';
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: personProfileClipOval(
                        context,
                        itm.avater!,
                        judgeAvater,
                        infoPersonalProfile(
                            itm.username!, header12, 'Judge', header10, 5, 0),
                        30,
                        pPbigMnthWidth,
                        pPbigMnthHeight,
                        prmry),
                  );
                },
              ),
            ),

            //Regisetered
            const SizedBox(
              height: 10,
            ),

            //Judges
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Famous On Show',
                style: header15,
              ),
            ),

            // Nomineted Members
            SizedBox(
              height: 120,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.show.superStarInfo.length,
                itemBuilder: (context, i) {
                  final itm = widget.show.superStarInfo[i];
                  final judgeAvater =
                      '${api}public/uploads/${itm.username!}/profile/${itm.avater!}';
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: personProfileClipOval(
                        context,
                        itm.avater!,
                        judgeAvater,
                        infoPersonalProfile(
                            itm.username!, header12, 'Team A', header10, 5, 0),
                        30,
                        pPbigMnthWidth,
                        pPbigMnthHeight,
                        prmry),
                  );
                },
              ),
            ),

            registered.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomineted Members',
                          style: header14,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          height: size.height / 2.5,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 4,
                                    childAspectRatio: 1),
                            itemCount: registered.length,
                            itemBuilder: (context, i) {
                              final itm = registered[i];

                              final urlImg =
                                  '${api}public/uploads/${itm.userInfo.username!}/profile/${itm.userInfo.avater!}';
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: personProfileClipOval(
                                    context,
                                    itm.userInfo.avater!,
                                    urlImg,
                                    infoPersonalProfile(itm.userInfo.username!,
                                        header12, 'Members', header10, 5, 0),
                                    20,
                                    35,
                                    35,
                                    prmry),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Expanded tvShowChats() {
    return Expanded(
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, index) {
          final itm = chats[index];
          final urlProfile =
              '${api}public/uploads/${itm.userInfo.username}/profile/';
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 10.0, bottom: 10),
            child: Column(
              children: [
                // Profile Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => HomeNav(
                                        user: User(
                                            id: itm.userId,
                                            username: itm.userInfo.username,
                                            avater: itm.userInfo.avater,
                                            phoneNo: '',
                                            role: '',
                                            gender: '',
                                            email: '',
                                            firstname: '',
                                            lastname: '',
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
                                        getIndex: 4,
                                      )));
                        },
                        child: personProfileClipOval(
                          context,
                          itm.userInfo.avater!,
                          urlProfile + itm.userInfo.avater!,
                          const SizedBox.shrink(),
                          18,
                          30,
                          30,
                          Colors.grey,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(chats[index].userInfo.username!,
                              style: TextStyle(
                                color: OColors.fontColor,
                                fontWeight: FontWeight.w600,
                              )),
                          GestureDetector(
                            onTap: () {
                              settngChat(context, itm);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.more_horiz_rounded,
                                    size: 12,
                                    color: OColors.fontColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //body Message
                Container(
                  padding: const EdgeInsets.only(left: 45, right: 8),
                  alignment: Alignment.topLeft,
                  child: Text(chats[index].body!,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: chatsFnts),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 30, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                likeUpdate(context, itm);
                              },
                              child: Icon(
                                itm.likeInfo.isLike == 'false'
                                    ? Icons.favorite_border_outlined
                                    : Icons.favorite,
                                color: OColors.primary,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            itm.likeInfo.number == '0'
                                ? const SizedBox.shrink()
                                : Text(itm.likeInfo.number!, style: emjFnts),
                          ],
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(chats[index].date, style: chatsTimeFnts),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void settngChat(BuildContext context, ChatsModel itm) { 
    double settingWdth = 100;
    double settingHegt = 30;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: const Color(0xFF737373),
              height: itm.chatInitiator == 'false' ? 300 : 200,
              child: Container(
                  decoration: BoxDecoration(
                      color: OColors.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          itm.chatInitiator == 'false'
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 19.0, top: 8.0, bottom: 8.0),
                                  child: Text('Select a reason',
                                      style: TextStyle(
                                          color: OColors.fontColor,
                                          fontSize: 16)))
                              : const SizedBox(),
                          itm.chatInitiator == 'true'
                              ? Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title:
                                            Text('Edit chat', style: header13),
                                        onTap: () {
                                          // Navigator.of(context).pop();
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (BuildContext context) => const LiveEve()));

                                          editChatDialog(context, itm);
                                        },
                                      ),
                                      ListTile(
                                        title: Text('Delete chat',
                                            style: header13),
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (BuildContext context) => const LiveEve()));

                                          newErrorAlertDialog(
                                              context,
                                              'Delete',
                                              'Are Sure you want to Delete...?',
                                              itm);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : // Radio Button
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.8,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        addRadioButton(0, 'Hate Speech'),
                                        addRadioButton(
                                            1, 'Harrashment or bullying'),
                                        addRadioButton(
                                            2, 'Mislaeading information'),
                                        addRadioButton(
                                            3, 'Ponography & nudity'),
                                        addRadioButton(
                                            4, 'Violent & graphic contents'),
                                        addRadioButton(5, 'Scams & Frauds'),
                                        addRadioButton(6, 'Spam'),
                                        addRadioButton(7,
                                            'Dangerous organization/individuals'),
                                        addRadioButton(8, 'Others'),
                                      ],
                                    ),
                                  ),
                                ),
                          itm.chatInitiator == 'false'
                              ? Column(
                                  children: [
                                    // const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          //cancel
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              width: settingWdth,
                                              height: settingHegt,
                                              decoration: BoxDecoration(
                                                  color: OColors.darGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Center(
                                                    child: Text(
                                                  'Cancel',
                                                  style: header12,
                                                )),
                                              ),
                                            ),
                                          ),
                                          //Submit
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              width: settingWdth,
                                              height: settingHegt,
                                              decoration: BoxDecoration(
                                                  color: OColors.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Center(
                                                    child: Text('Submit',
                                                        style: header12)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink()
                        ],
                      ))));
        });
  }

  newErrorAlertDialog(
      BuildContext context, String title, String msg, ChatsModel itm) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("cancel",
          style: TextStyle(
            color: OColors.primary,
          )),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      ),
      child: const Text("Ok"),
      onPressed: () {
        deletePost(context, itm);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // insetPadding: const EdgeInsets.only(left: 20, right: 20),
      // contentPadding: EdgeInsets.zero,
      // titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: header18),
      ),
      content: Text(msg, style: header12),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  editChatDialog(BuildContext context, ChatsModel itm) async {
    _edtChat.text = itm.body!;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("cancel",
          style: TextStyle(
            color: OColors.primary,
          )),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      ),
      child: const Text("Ok"),
      onPressed: () {
        updateChat(context, itm, _edtChat);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // insetPadding: const EdgeInsets.only(left: 20, right: 20),
      // contentPadding: EdgeInsets.zero,
      // titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text('Update', style: header18),
      ),
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            textFieldContainer(
                context,
                'Edit Chat',
                _edtChat,
                MediaQuery.of(context).size.width / 1.4,
                90,
                8,
                10,
                OColors.darGrey,
                null,
                header12)
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
