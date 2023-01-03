import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/pallets.dart';

import '../../model/user/user-call.dart';
import '../../model/bigMontTvShow/bigMonth-Model.dart';
import '../../model/bigMontTvShow/bigMonth-call.dart';

import '../../model/ceremony/crm-model.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/login_widget/service-background.dart.dart';
import '../admin/bgMonth-registered.dart';
import '../admin/bigMonth-List.dart';
import '../admin/bigMonth-admin.dart';
import 'bigMontth-wall.dart';

class BigMonthTvShow extends StatefulWidget {
  final String from;
  const BigMonthTvShow({Key? key, required this.from}) : super(key: key);

  @override
  State<BigMonthTvShow> createState() => _BigMonthTvShowState();
}

class _BigMonthTvShowState extends State<BigMonthTvShow> {
  final TextEditingController _birthdayDateController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  List<BigMonthModel> shows = [];

  BigMonthModel show = BigMonthModel(
      id: '',
      title: '',
      description: '',
      season: '',
      episode: '',
      showImage: '',
      dedline: '',
      showDate: '',
      judgesId: '',
      superStarsId: '',
      status: '',
      isRegistered: '',
      judgesInfo: [
        User(
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
            totalLikes: '')
      ],
      superStarInfo: [
        User(
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
            totalLikes: '')
      ],
      createdDate: '');

  BigMonthModel newShow = BigMonthModel(
      id: '',
      title: '',
      description: '',
      season: '',
      episode: '',
      showImage: '',
      dedline: '',
      showDate: '',
      judgesId: '',
      superStarsId: '',
      status: '',
      isRegistered: '',
      judgesInfo: [
        User(
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
            totalLikes: '')
      ],
      superStarInfo: [
        User(
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
            totalLikes: '')
      ],
      createdDate: '');

  _regstrationBigMonth(BuildContext context, TextEditingController date,
      TextEditingController contact, registerAs) {
    if (date.text.isNotEmpty) {
      if (contact.text.isNotEmpty) {
        BigMonthShowCall(payload: [], status: 0)
            .postBigMonthRegistration(token, urlBigMonthRegistration, show.id,
                date.text, contact.text, registerAs)
            .then((v) {
          setState(() {
            Navigator.of(context).pop();
            onPageAlertDialog(context, l(sw, 23), v.payload);
          });
        });
      } else {
        errorAlertDialog(
            context, l(sw, 8), 'Enter your contact for contact you Please..');
      }
    } else {
      errorAlertDialog(context, l(sw, 45), 'Enter your Birthdate  Please..');
    }
  }

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
    meritalStatus: '',
    totalPost: '',
    isCurrentBsnAdmin: '',
    isCurrentCrmAdmin: '',
    totalFollowers: '',
    totalFollowing: '',
    totalLikes: '');

    CeremonyModel ceremony = CeremonyModel(
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
  userFid: User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      address: '',
      meritalStatus: '',
      bio: '',
      totalPost: '',
      isCurrentUser: '',
      isCurrentCrmAdmin: '',
      isCurrentBsnAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: ''),
  userSid: User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      address: '',
      meritalStatus: '',
      bio: '',
      totalPost: '',
      isCurrentUser: '',
      isCurrentCrmAdmin: '',
      isCurrentBsnAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: ''),
  youtubeLink: '',
);


  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser(urlGetUser);
        getShow('$urlGetBigMonthPacakge/status/$bigMonthShowStatus', 'new');
        getShow(urlGetBigMonth, 'all');
      });
    });
    super.initState();
  }

  Future getUser(String dirUrl) async {
    return await UsersCall(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          currentUser = User.fromJson(value.payload);
        });
      }
    });
  }

  getShow(url, tvShow) {
    BigMonthShowCall(payload: [], status: 0).get(token, url).then((value) {
      if (value.status == 200) {
        final e = value.payload;
        setState(() {
          if (tvShow == 'new') {
            show = BigMonthModel.fromJson(e);
          } else {
            shows = value.payload
                .map<BigMonthModel>((e) => BigMonthModel.fromJson(e))
                .toList();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return show.id != ''
        ? Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: ServicesBackgroundImage(
                      image: urlBigShowImg + show.showImage)),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: topBar(),
                body: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            rowBundlePosition(
                              context,
                              size,
                              l(sw, 12),
                              show.title,
                              'Season ${show.season}',
                              urlBigShowImg + show.showImage,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 100,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 18, top: 5, right: 4),
                              child: Text(
                                show.description,
                                style: header12.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 70,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, bottom: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tv Shows Seasons',
                                    style: header14.copyWith(
                                        color: OColors.darkGrey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      bisShowsViewers(size);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: OColors.primary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 5,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: shows.length,
                                itemBuilder: (context, i) {
                                  final itm = shows[i];
                                  return GestureDetector(
                                    onTap: () {
                                      if (itm.status == 'true') {
                                        if (itm.isRegistered == 'true') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          BigMonthWall(
                                                            currentUser:
                                                                currentUser,
                                                            show: itm,
                                                          )));
                                        } else {
                                          registerAs(
                                              context, 'Register As', itm);
                                        }
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        BigMonthWall(
                                                          currentUser:
                                                              currentUser,
                                                          show: itm,
                                                        )));
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 1.0, right: 1.0),
                                      padding: const EdgeInsets.all(4.0),
                                      child: crmBundle(
                                          context,
                                          urlBigShowImg + itm.showImage,
                                          'BigJune',
                                          'SE ${itm.season} Ep ${itm.episode}',
                                          110),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        : SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loadingFunc(37, prmry),
              ],
            ),
          );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: osec.withOpacity(.1),
      toolbarHeight: 40,
      elevation: 0,
      actions: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.reply,
            color: Colors.white,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        currentUser.role == 'a'
            ? GestureDetector(
                onTap: () {
                  adminOnly();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              )
            : Text(currentUser.role!),
      ],
    );
  }

  SizedBox rowBundlePosition(BuildContext context, size, String subtitle,
      String title, String season, img) {
    return SizedBox(
      // color: Colors.red,
      width: size.width,
      // height: size.height / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Tv Show Title
          Container(
            // color: Colors.red,
            margin: const EdgeInsets.only(left: 18.0),
            padding: const EdgeInsets.only(left: 4),
            width: MediaQuery.of(context).size.width / 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                      color: OColors.primary,
                      border: Border.all(color: OColors.primary, width: 1.2),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    subtitle,
                    style: header14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: header18.copyWith(
                      fontSize: 19,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      wordSpacing: 4.2),
                ),
              ],
            ),
          ),

          //New Tv Show Register
          GestureDetector(
            onTap: () {
              if (show.status == 'true') {
                if (show.isRegistered == 'true') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BigMonthWall(
                                currentUser: currentUser,
                                show: show,
                              )));
                } else {
                  registerAs(context, 'Register As', show);
                }
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => BigMonthWall(
                              currentUser: currentUser,
                              show: show,
                            )));
              }
            },
            child: Container(
              // color: Colors.red,
              margin: const EdgeInsets.only(right: 10),
              width: 105,
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title
                  Container(
                    padding: const EdgeInsets.only(
                        left: 0, right: 8, top: 4, bottom: 4),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Text(
                      season,
                      style: header14.copyWith(
                          fontWeight: FontWeight.bold, color: prmry),
                    ),
                  ),

                  // TImage
                  Stack(
                    children: [
                      InkWell(
                          child: fadeImg(
                              context, img, size.width / 3, size.height / 6.5)),
                      Positioned(
                          bottom: 0,
                          child: Container(
                              width: 100,
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                  color: OColors.primary.withOpacity(.8)),
                              child: Center(
                                child: show.isRegistered != 'true'
                                    ? Text(l(sw, 12) + ' Now',
                                        style: header11.copyWith(
                                            fontWeight: FontWeight.w400))
                                    : Text(
                                        l(sw, 46),
                                        style: header11.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container crmBundle(
      BuildContext context, url, price, String title, double w) {
    return Container(
      width: w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: OColors.darGrey),
      child: Stack(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: fadeImg(context, url, MediaQuery.of(context).size.width / 1,
                MediaQuery.of(context).size.height / 5)),
        Positioned(
            top: 8,
            left: 0,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: OColors.primary.withOpacity(.8)),
              child: Text(
                title,
                style: header11.copyWith(fontWeight: FontWeight.w400),
              ),
            )),
        Positioned(
            bottom: 0,
            child: Container(
              width: 120,
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: OColors.secondary.withOpacity(.8)),
              child: Center(
                child: Text(
                  price,
                  style: header11.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            )),
      ]),
    );
  }

  registerAs(BuildContext context, String title, BigMonthModel itm) async {
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
      child: const SizedBox.shrink(),
      onPressed: () {
        // deletePost(context, itm);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      contentPadding: EdgeInsets.zero,
      // titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: header18),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.1,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                registerTvShow(context, '', itm, 'audience');
              },
              child: flatButton(
                  context,
                  'Audience',
                  header11.copyWith(fontWeight: FontWeight.bold),
                  40,
                  90,
                  OColors.primary.withOpacity(.3),
                  80,
                  10,
                  10),
            ),
            GestureDetector(
              onTap: () {
                //Show Alert Dialog Alert function

                Navigator.of(context).pop();
                registerTvShow(context, '', itm, 'cast');
              },
              child: flatButton(
                  context,
                  'Participant',
                  header11.copyWith(fontWeight: FontWeight.bold),
                  40,
                  95,
                  OColors.primary,
                  80,
                  10,
                  10),
            ),
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

  // Second Content Dialog for Register user Widget
  SizedBox bigMonthRegistration(BuildContext context, size) {
    var sStarAvater0 =
        '${api}public/uploads/${show.superStarInfo[0].username!}/profile/${show.superStarInfo[0].avater!}';
    var sStarAvater1 =
        '${api}public/uploads/${show.superStarInfo[1].username!}/profile/${show.superStarInfo[1].avater!}';

    double pwidth = 50;
    double pheight = 50;
    return SizedBox(
      width: size.width / 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 13,
            ),
            Row(
              children: [
                SizedBox(
                  width: 155,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        alignment: Alignment.topLeft,
                        child: Text('Enter  your BirthDate',
                            style:
                                header12.copyWith(fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      dateDialog(
                          context,
                          _birthdayDateController,
                          MediaQuery.of(context).size.width / 1.5,
                          40,
                          5,
                          gry1,
                          dateStyl),
                    ],
                  ),
                ),
                SizedBox(
                  width: 155,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.only(bottom: 8.0),
                        alignment: Alignment.topLeft,
                        child: Text('Enter  your Contact',
                            style:
                                header12.copyWith(fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      textFieldContainer(
                          context,
                          'Enter Contact',
                          _contactController,
                          MediaQuery.of(context).size.width / 1.5,
                          40,
                          10,
                          10,
                          gry1,
                          Icon(
                            Icons.call,
                            size: 20,
                            color: prmry,
                          ),
                          textStyl,TextInputType.phone),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 8,
              child: Divider(
                height: 1.0,
                color: OColors.darkGrey,
                thickness: 1.0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Judges On Show',
                style: header14.copyWith(),
              ),
            ),

            // Judges List

            SizedBox(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: show.judgesInfo.length,
                  itemBuilder: (context, i) {
                    final itm = show.judgesInfo[i];

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
                  }),
            ),

            const SizedBox(
              height: 15,
            ),
            //Header
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Famous On BigMonth Show',
                style: header14,
              ),
            ),
            // Team show
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Team A
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'TEAM A',
                        style: header13,
                      ),
                    ),
                    personProfileClipOval(
                        context,
                        show.superStarInfo[0].avater!,
                        sStarAvater0,
                        infoPersonalProfile(show.superStarInfo[0].username!,
                            header12, 'Musician', header10, 5, 0),
                        30,
                        pPbigMnthWidth,
                        pPbigMnthHeight,
                        prmry),
                  ],
                ),
                // Team B
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'TEAM B',
                        style: header13,
                      ),
                    ),
                    personProfileClipOval(
                        context,
                        show.superStarInfo[1].avater!,
                        sStarAvater1,
                        infoPersonalProfile(show.superStarInfo[1].username!,
                            header12, 'Actor', header10, 5, 0),
                        30,
                        pwidth,
                        pheight,
                        prmry),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  registerTvShow(
      BuildContext context, String title, BigMonthModel itm, String rgstType) {
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.only(right: 1, left: 1),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 5),
      backgroundColor: OColors.secondary,
      actionsPadding: EdgeInsets.zero,
      title: titleDIalog(context, 'THE BIGMONTH TV SHOW'),
      content: bigMonthRegistration(context, MediaQuery.of(context).size),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: bttnStyl(6, trans, fntClr),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                l(sw, 19),
                style: header13.copyWith(
                    fontWeight: FontWeight.normal, color: OColors.fontColor),
              ),
            ),
            GestureDetector(
              onTap: () {
                _regstrationBigMonth(context, _birthdayDateController,
                    _contactController, rgstType);
              },
              child: flatButton(
                  context, l(sw, 12), header13, 30, 80, prmry, 10, 10, 10),
            )
          ],
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void adminOnly() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 250,
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
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AddBigMonthTvShow(
                                            show: newShow,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Add BigMonth Show', style: header14),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const BigMonthShowList()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('View BigMonth Shows', style: header14),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const BigMonthRegistered()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('View Registers', style: header14),
                            )),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AddBigMonthTvShow(
                                            show: show,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('Edit BigMonth Show', style: header14),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ))),
          );
        });
  }

  void bisShowsViewers(size) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: size.height,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'BIGMONTH TV  SHOWS',
                            style: title.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: size.height / 2.3,
                          child: ListView.builder(
                              itemCount: shows.length,
                              itemBuilder: (context, i) {
                                final itm = shows[i];
                                return ListTile(
                                  onTap: () {
                                    if (itm.status == 'true') {
                                      if (itm.isRegistered == 'true') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        BigMonthWall(
                                                          currentUser:
                                                              currentUser,
                                                          show: itm,
                                                        )));
                                      } else {
                                        registerAs(context, 'Register As', itm);
                                      }
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  BigMonthWall(
                                                    currentUser: currentUser,
                                                    show: itm,
                                                  )));
                                    }
                                  },
                                  leading: SizedBox(
                                    height: 60,
                                    width: 70,
                                    child: fadeImg(
                                        context,
                                        urlBigShowImg + itm.showImage,
                                        size.width / 1,
                                        size.height / 1.5),
                                  ),
                                  title: Text(
                                    'Season ${itm.season}',
                                    style: header13,
                                  ),
                                  subtitle: Text(
                                    'Episode ${itm.episode}',
                                    style: header11,
                                  ),
                                  trailing: Text(itm.showDate,
                                      style: header14.copyWith(
                                        fontWeight: FontWeight.bold,
                                      )),
                                );
                              }),
                        )
                      ],
                    ))),
          );
        });
  }

  onPageAlertDialog(BuildContext context, String title, String msg) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Ok",
          style: TextStyle(
            color: OColors.primary,
          )),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      },
    );

    Widget continueButton = TextButton(
      child: const SizedBox.shrink(),
      onPressed: () {},
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
}
