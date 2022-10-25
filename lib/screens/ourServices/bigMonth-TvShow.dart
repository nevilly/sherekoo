import 'package:flutter/material.dart';
import 'package:sherekoo/screens/ourServices/srvDetails.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/allData.dart';
import '../../model/crmBundle/bundle.dart';
import '../../model/crmBundle/crmbundle.dart';
import '../../model/crmPackage/crmPackage.dart';
import '../../model/crmPackage/crmPackageModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/func.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/login_widget/background-image.dart';
import '../admin/crmPckSelect.dart';
import '../admin/crnBundleOrders.dart';
import '../admin/bigMonth-admin.dart';

class BigMonthTvShow extends StatefulWidget {
  final String from;
  const BigMonthTvShow({Key? key, required this.from}) : super(key: key);

  @override
  State<BigMonthTvShow> createState() => _BigMonthTvShowState();
}

class _BigMonthTvShowState extends State<BigMonthTvShow> {
  final TextEditingController _birthdayDateController = TextEditingController();
  final Preferences _preferences = Preferences();
  String token = '';
  String status = '1';

  List<Bundle> bundle = [];
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

  _regstrationBigMonth(BuildContext context, date) {
    //  BundleOrders(status:0,payload:[]).postOrders(token, dirUrl, ceremonyDate, showBundleId, crmBundleId, crmId)
  }

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;

        getlatestPackage();
        getCrmBundle();
        getUser(urlGetUser);
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

  getlatestPackage() {
    CrmPackage(payload: [], status: 0)
        .get(token, '$urlGetCrmPackage/status/true')
        .then((value) {
      if (value.status == 200) {
        final e = value.payload;
        setState(() {
          pck = CrmPckModel.fromJson(e);
        });
      }
    });
  }

  getCrmBundle() async {
    CrmBundle(payload: [], status: 0).get(token, urlGetCrmBundle).then((value) {
      if (value.status == 200) {
        setState(() {
          bundle =
              value.payload.map<Bundle>((e) => Bundle.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            child: const BackgroundImage(image: "assets/login/03.jpg")),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: topBar(),
          body: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height / 100,
                      // ),
                      rowBundlePosition(
                        context,
                        'Register',
                        'The Only Best BigMonthy Tv Show ',
                        'Season 01',
                        "assets/ceremony/hs1.jpg",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 100,
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 18, top: 5, right: 4),
                        child: Text(
                          'Season 1 it will deal with all those who get berth in january only. The show is going to be more funny and Winner will  do Offer him best ceremony ,.',
                          style:
                              header12.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tv Shows Seasons',
                              style: header14.copyWith(
                                  color: OColors.darkGrey,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: OColors.primary,
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
                          itemCount: bundle.length,
                          itemBuilder: (context, i) {
                            final itm = bundle[i];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ServiceDetails(
                                                bundle: itm,
                                                currentUser: currentUser)));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 1.0, right: 1.0),
                                padding: const EdgeInsets.all(4.0),
                                child: crmBundle(
                                    context,
                                    "assets/ceremony/hs1.jpg",
                                    itm.price,
                                    itm.bundleType,
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
    );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
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

  Column rowBundlePosition(
      BuildContext context, String subtitle, String title, String season, img) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
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
                          border:
                              Border.all(color: OColors.primary, width: 1.2),
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
                  showAlertDialog(
                    context,
                    titleDIalog(context, 'Registor'),
                    choosingAplication(context),
                    dialogButton(context, 'cancel', bttnStyl(0, fntClr, trans),
                        () {
                      Navigator.of(context).pop();
                    }),
                    dialogButton(context, '', bttnStyl(0, trans, trans), () {
                      Navigator.of(context).pop();
                    }),
                  );
                  // showAlertDialog(context, 'Select Ceremony ', '', '', '');
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
                            left: 0, right: 8, top: 4, bottom: 8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Text(
                          season,
                          style: header14.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),

                      // TImage
                      Stack(
                        children: [
                          InkWell(
                            child: Image.asset(
                              img,
                              // width: 90,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                    color: OColors.primary.withOpacity(.8)),
                                child: Center(
                                  child: Text(
                                    'Register Now',
                                    style: header11.copyWith(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
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
            child: Image.asset(
              url,
              height: 140,
              fit: BoxFit.cover,
            )),
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
                  price + ' Tsh/',
                  style: header11.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            )),
      ]),
    );
  }

  /// first Content DialogBox for user to choose Register type
  SizedBox choosingAplication(BuildContext context) {
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
                2.8,
                OColors.primary.withOpacity(.3),
                80,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //Show Alert Dialog Alert function

              Navigator.of(context).pop();
              showAlertDialog(
                  context,
                  titleDIalog(context, 'THE BIGMONTH TV SHOW'), //Title
                  bigMonthRegistration(context), // Content
                  dialogButton(context, 'cancel', bttnStyl(6, trans, fntClr),
                      reggster(context)), //Cancel Button
                  GestureDetector(
                    onTap: () {
                      _regstrationBigMonth(
                          context, _birthdayDateController.text);
                    },
                    child: flatButton(
                      context,
                      'Regiter',
                      header13,
                      30,
                      2.5,
                      prmry,
                      10,
                    ),
                  ));
            },
            child: flatButton(
                context,
                'As Participant',
                header11.copyWith(fontWeight: FontWeight.bold),
                40,
                2.8,
                OColors.primary,
                80),
          ),
        ],
      ),
    );
  }

  // Second Content Dialog for Register user Widget
  SizedBox bigMonthRegistration(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Judges On Show',
            style: header14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              personProfile(context, 'url', 'userInfo', 'itm'),
              personProfile(context, 'url', 'userInfo', 'itm'),
              personProfile(context, 'url', 'userInfo', 'itm'),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Famous On BigMonth Show',
            style: header14,
          ),
          // Team show
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'TEAM A',
                    style: header13,
                  ),
                  personProfile(context, 'url', 'userInfo', 'itm'),
                ],
              ),
              Column(
                children: [
                  Text(
                    'TEAM B',
                    style: header13,
                  ),
                  personProfile(context, 'url', 'userInfo', 'itm'),
                ],
              ),
            ],
          ),

          const Spacer(),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.only(bottom: 8.0),
                alignment: Alignment.topLeft,
                child: Text('Enter  your BirthDate',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: OColors.fontColor),
                    textAlign: TextAlign.start),
              ),
              const SizedBox(
                height: 6,
              ),
              dateDialog(context, _birthdayDateController, 1, 40,10, gry1,dateStyl)
            ],
          )
        ],
      ),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const AddBigMonthTvShow()));
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const CrmPckList()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('View BigMonth Shows', style: header14),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
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
}
