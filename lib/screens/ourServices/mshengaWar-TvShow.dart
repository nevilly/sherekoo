import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/pallets.dart';

import '../../model/allData.dart';
import '../../model/bigMontTvShow/bigMonth-call.dart';

import '../../model/mshengaWar/mshengaWar-Model.dart';
import '../../model/mshengaWar/mshengaWar-call.dart';
import '../../model/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/login_widget/service-background.dart.dart';
import '../admin/crnBundleOrders.dart';
import '../admin/mshenga-admin.dart';
import '../admin/mshengaShow-list.dart';
import 'mshengaWall.dart';

class MshengaWarTvShow extends StatefulWidget {
  final String from;
  const MshengaWarTvShow({Key? key, required this.from}) : super(key: key);

  @override
  State<MshengaWarTvShow> createState() => _MshengaWarTvShowState();
}

class _MshengaWarTvShowState extends State<MshengaWarTvShow> {
  final TextEditingController _birthdayDateController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  List<MshengaWarModel> shows = [];

  MshengaWarModel show = MshengaWarModel(
      id: '',
      title: '',
      description: '',
      season: '',
      episode: '',
      showImage: '',
      dedline: '',
      showDate: '',
      status: '',
      isRegistered: '',
      washengaInfo: [
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
      createdDate: '',
      washengaId: '');

  _regstrationBigMonth(BuildContext context, TextEditingController date,
      TextEditingController contact) {
    if (date.text.isNotEmpty) {
      if (contact.text.isNotEmpty) {
        BigMonthShowCall(payload: [], status: 0)
            .postBigMonthRegistration(token, urlBigMonthRegistration, show.id,
                date.text, contact.text)
            .then((v) {
          setState(() {
            Navigator.of(context).pop();
            show.isRegistered = 'true';
            errorAlertDialog(context, l(sw, 23), v.payload);
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

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser(urlGetUser);
        getShow('$urlGeMshengaWarPacakge/status/$mshengaWarShowStatus', 'new');
        getShow(urlGetMshengaWar, 'all');
      });
    });
    super.initState();
  }

  Future getUser(String dirUrl) async {
    return await AllUsersModel(payload: [], status: 0)
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
    MshengaWarCall(payload: [], status: 0).get(token, url).then((value) {
      if (value.status == 200) {
        final e = value.payload;
        setState(() {
          if (tvShow == 'new') {
            show = MshengaWarModel.fromJson(e);
          } else {
            shows = value.payload
                .map<MshengaWarModel>((e) => MshengaWarModel.fromJson(e))
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
                      image: urlMshenngaShowImg + show.showImage)),
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
                              urlMshenngaShowImg + show.showImage,
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
                                      if (show.status == 'true') {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder:
                                        //             (BuildContext context) =>
                                        //                 BigMonthWall(
                                        //                   currentUser:
                                        //                       currentUser,
                                        //                   show: itm,
                                        //                 )));
                                      } else {
                                        itm.isRegistered == 'true'
                                            ? print('ok')
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (BuildContext
                                            //                 context) =>
                                            //             BigMonthWall(
                                            //               currentUser:
                                            //                   currentUser,
                                            //               show: itm,
                                            //             )))
                                            : showAlertDialog(
                                                context,
                                                titleDIalog(context, l(sw, 12)),
                                                choosingAplication(
                                                    context, size),
                                                dialogButton(context, 'cancel',
                                                    bttnStyl(0, fntClr, trans),
                                                    () {
                                                  Navigator.of(context).pop();
                                                }),
                                                dialogButton(context, '',
                                                    bttnStyl(0, trans, trans),
                                                    () {
                                                  Navigator.of(context).pop();
                                                }),
                                              );
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 1.0, right: 1.0),
                                      padding: const EdgeInsets.all(4.0),
                                      child: crmBundle(
                                          context,
                                          urlMshenngaShowImg + itm.showImage,
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
              show.isRegistered != 'true'
                  ? showAlertDialog(
                      context,
                      titleDIalog(context, l(sw, 12)),
                      choosingAplication(context, size),
                      dialogButton(
                          context, 'cancel', bttnStyl(0, fntClr, trans), () {
                        Navigator.of(context).pop();
                      }),
                      dialogButton(context, '', bttnStyl(0, trans, trans), () {
                        Navigator.of(context).pop();
                      }),
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MshengaWarWall(
                                currentUser: currentUser,
                                show: show,
                              )));
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

  reggster(BuildContext context) {
    Navigator.of(context).pop();
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

  /// first Content DialogBox for user to choose Register type
  SizedBox choosingAplication(BuildContext context, size) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: GestureDetector(
              onTap: () {},
              child: flatButton(
                  context,
                  'As audience',
                  header11.copyWith(fontWeight: FontWeight.bold),
                  40,
                  60,
                  OColors.primary.withOpacity(.3),
                  80,
                  10,
                  10),
            ),
          ),
          GestureDetector(
            onTap: () {
              //Show Alert Dialog Alert function

              Navigator.of(context).pop();
              showAlert(context, size);
            },
            child: flatButton(
                context,
                'As Participant',
                header11.copyWith(fontWeight: FontWeight.bold),
                40,
                70,
                OColors.primary,
                80,
                10,
                10),
          ),
        ],
      ),
    );
  }

  // Second Content Dialog for Register user Widget
  SizedBox bigMonthRegistration(BuildContext context, size) {
    var sStarAvater0 =
        '${api}public/uploads/${show.washengaInfo[0].username!}/profile/${show.washengaInfo[0].avater!}';
    var sStarAvater1 =
        '${api}public/uploads/${show.washengaInfo[1].username!}/profile/${show.washengaInfo[1].avater!}';

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
                          textStyl),
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
                'Washenga On Show',
                style: header14.copyWith(),
              ),
            ),

            // Washenga List

            SizedBox(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: show.washengaInfo.length,
                  itemBuilder: (context, i) {
                    final itm = show.washengaInfo[i];

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
          ],
        ),
      ),
    );
  }

  showAlert(BuildContext context, size) {
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.only(right: 1, left: 1),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 5),
      backgroundColor: OColors.secondary,
      actionsPadding: EdgeInsets.zero,
      title: titleDIalog(context, 'THE BIGMONTH TV SHOW'),
      content: bigMonthRegistration(context, size),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: bttnStyl(6, trans, fntClr),
              onPressed: () {
                reggster(context);
              },
              child: Text(
                l(sw, 19),
                style: header13.copyWith(
                    fontWeight: FontWeight.normal, color: OColors.fontColor),
              ),
            ),
            GestureDetector(
              onTap: () {
                _regstrationBigMonth(
                    context, _birthdayDateController, _contactController);
              },
              child: flatButton(
                  context, l(sw, 12), header13, 30, 70, prmry, 10, 10, 10),
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
            height: 190,
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
                                          AddMshengaWarTvShow(
                                            show: show,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('Add MshengaWar Show', style: header14),
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
                                          const MshengaShowList()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('View MshengaWar Shows',
                                  style: header14),
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
                                          const CrmBundleOrders()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('View Registers', style: header14),
                            )),
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
                                    if (show.status == 'true') {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MshengaWarWall(
                                                    currentUser: currentUser,
                                                    show: itm,
                                                  )));
                                    } else {
                                      if (itm.isRegistered == 'true') {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MshengaWarWall(
                                                          currentUser:
                                                              currentUser,
                                                          show: itm,
                                                        )));
                                      } else {
                                        showAlertDialog(
                                          context,
                                          titleDIalog(context, l(sw, 12)),
                                          choosingAplication(context, size),
                                          dialogButton(context, 'cancel',
                                              bttnStyl(0, fntClr, trans), () {
                                            Navigator.of(context).pop();
                                          }),
                                          dialogButton(context, '',
                                              bttnStyl(0, trans, trans), () {
                                            Navigator.of(context).pop();
                                          }),
                                        );
                                      }
                                    }
                                  },
                                  leading: SizedBox(
                                    height: 60,
                                    width: 70,
                                    child: fadeImg(
                                        context,
                                        urlMshenngaShowImg + itm.showImage,
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
}
