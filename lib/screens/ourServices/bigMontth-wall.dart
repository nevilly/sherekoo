import 'package:flutter/material.dart';
import 'package:sherekoo/model/bigMontTvShow/bigMonth-call.dart';
import '../../model/bigMontTvShow/bigMnth-Reg-Memb.dart';
import '../../model/bigMontTvShow/bigMonth-Model.dart';
import '../../model/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';

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

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {});

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
        isUserIdRegister = widget.show.isUserIdRegister;
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

  // Container flatButton(String text) {
  //   return Container(
  //     margin: const EdgeInsets.only(left: 10, right: 20, top: 15, bottom: 15),
  //     padding: const EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 4),
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //         color: OColors.primary,
  //         borderRadius: const BorderRadius.all(Radius.circular(80))),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(50),
  //       child: Container(
  //         decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(50))),
  //         child: Text(
  //           text,
  //           style: header11.copyWith(fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
        child: ListView(
          children: [
            // const SizedBox(height: 25),

            Text('Chats', style: header12)
          ],
        ),
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

          Text(
            'Selected Show Members',
            style: header16,
          ),
            const SizedBox(
              height: 5,
            ),

            Container(
              padding: const EdgeInsets.all(6),
              height: size.height / 2.5,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    childAspectRatio: 1.1),
                itemCount: registered.length,
                itemBuilder: (context, i) {
                  final itm = registered[i];

                  final urlImg =
                      '${api}public/uploads/${itm.userInfo.username!}/profile/${itm.userInfo.avater!}';
                  return Stack(
                    children: [
                      fadeImg(context, urlImg, size.width, size.height),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: 115,
                          color: OColors.secondary.withOpacity(.6),
                          child: infoPersonalProfile(itm.userInfo.username!,
                              header11, 'member', header10, 5, 0),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          
          ],
        ),
      ),
    );
  }
}
