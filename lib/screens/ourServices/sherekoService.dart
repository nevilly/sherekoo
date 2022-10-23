import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherekoo/screens/ourServices/srvDetails.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/allData.dart';
import '../../model/crmBundle/bundle.dart';
import '../../model/crmBundle/crmbundle.dart';
import '../../model/crmPackage/crmPackage.dart';
import '../../model/crmPackage/crmPackageModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/modInstance.dart';
import '../../util/util.dart';
import '../../widgets/login_widget/background-image.dart';
import '../admin/crmPackageAdd.dart';
import '../admin/crmPckSelect.dart';
import '../admin/crnBundleOrders.dart';

class SherekoService extends StatefulWidget {
  final String from;
  const SherekoService({Key? key, required this.from}) : super(key: key);

  @override
  State<SherekoService> createState() => _SherekoServiceState();
}

class _SherekoServiceState extends State<SherekoService> {
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

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        if (widget.from == 'crmBundle') {
          getlatestPackage();
          getCrmBundle();
          getUser(urlGetUser);
        }
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
                      if (widget.from == 'crmBundle')
                        crmBundlePosition(context),
                      if (widget.from == 'Mr&MrsMy')
                        rowBundlePosition(
                          context,
                          'Register',
                          'Our Best Mr&Mrs My Tv Show ',
                          'Season 01',
                          "assets/ceremony/hs1.jpg",
                        ),
                      if (widget.from == 'MyBdayShow')
                        rowBundlePosition(
                          context,
                          'Register',
                          'Our Best  MyBirthMonth Tv Show ',
                          'Season 01',
                          "assets/ceremony/hs1.jpg",
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 100,
                      ),
                      if (widget.from == 'MyBdayShow')
                        Container(
                          padding:
                              const EdgeInsets.only(left: 18, top: 5, right: 4),
                          child: Text(
                            'Season 1 it will deal with all those who get berth in january only. The show is going to be more funny and Winner will  do Offer him best ceremony ,.',
                            style: header12.copyWith(
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      if (widget.from == 'crmBundle')
                        Container(
                          padding:
                              const EdgeInsets.only(left: 18, top: 5, right: 4),
                          child: Text(
                            pck.descr,
                            style: header10.copyWith(
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      if (widget.from == 'Mr&MrsMy')
                        Container(
                          padding:
                              const EdgeInsets.only(left: 18, top: 5, right: 4),
                          child: Text(
                            'Lorem ipsum  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, Excepteur sint occaecat cupidatat non proident,.',
                            style: header11.copyWith(
                                fontWeight: FontWeight.normal),
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
                              'Bundles',
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
                      if (widget.from == 'crmBundle')
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
                                              ServiceDetails(bundle: itm,currentUser:currentUser)));
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
                      if (widget.from == 'Mr&MrsMy')
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (BuildContext context) =>
                                  //             const ServiceDetails()));
                                },
                                child: crmBundle(
                                    context,
                                    "assets/ceremony/hs1.jpg",
                                    '2,500,000',
                                    'House Part',
                                    110),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              crmBundle(context, "assets/ceremony/hs2.jpg",
                                  '20,500,000', 'Wedding', 110),
                              const SizedBox(
                                width: 10,
                              ),
                              crmBundle(context, "assets/ceremony/b1.png",
                                  '1,500,000', 'SendOff', 110),
                              const SizedBox(
                                width: 10,
                              ),
                              crmBundle(context, "assets/ceremony/hs2.jpg",
                                  '3,500,000', '5 years', 110),
                              const SizedBox(
                                width: 10,
                              ),
                              crmBundle(context, "assets/ceremony/hs2.jpg",
                                  '3,500,000', '10 years', 110),
                              const SizedBox(
                                width: 10,
                              ),
                              crmBundle(context, "assets/ceremony/hs2.jpg",
                                  '3,500,000', '15 years', 110),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
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
            : const SizedBox.shrink(),
      ],
    );
  }

  SizedBox crmBundlePosition(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
            decoration: BoxDecoration(
                color: OColors.primary,
                border: Border.all(color: OColors.primary, width: 1.2),
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              'Booking',
              style: header12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 8.0),
            padding: const EdgeInsets.only(left: 8),
            width: MediaQuery.of(context).size.width / 1.7,
            child: Text(
              pck.title,
              style: header18.copyWith(
                  fontSize: 19,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  wordSpacing: 4.2),
            ),
          ),
        ],
      ),
    );
  }

  Positioned rowBundlePosition(
      BuildContext context, String subtitle, String title, String season, img) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.red,
                  margin: const EdgeInsets.only(left: 18.0),
                  padding: const EdgeInsets.only(left: 4),
                  width: MediaQuery.of(context).size.width / 2.1,
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
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 100,
                  height: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      GestureDetector(
                        onTap: () {
                          showAlertDialog(
                              context, 'Select Ceremony ', '', '', '');
                        },
                        child: Stack(
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
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

  // Alert Widget
  showAlertDialog(
      BuildContext context, String title, String msg, req, String from) async {
    // set up the buttons

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.only(right: 1, left: 1),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 5),
      backgroundColor: OColors.secondary,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.close,
              size: 35,
              color: OColors.fontColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 38.0, top: 8, bottom: 8),
          child: Text('Search',
              style:
                  header18.copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ]),
      content: Column(
        children: [
          birthDayMonth('Birthday Date', _birthdayDateController),
        ],
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  birthDayMonth(title, dateController) {
    return Container(
        width: MediaQuery.of(context).size.width,
        // color: OColors.fontColor,
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              padding: const EdgeInsets.only(bottom: 8.0),
              alignment: Alignment.topLeft,
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: OColors.fontColor),
                  textAlign: TextAlign.start),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: dateController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Icons.calendar_month,
                      size: 28,
                      color: OColors.primary,
                    ),
                  ),
                  hintText: 'Date ( DD/MM/YYY )',
                  hintStyle: const TextStyle(color: Colors.grey, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Colors.grey, height: 1.5),
                onTap: () {
                  _selectDate(context, dateController);
                },
              ),
            ),
          ],
        ));
  }

  DateTime? _selectedDate;
  // Date Selecting Function
  _selectDate(BuildContext context, textEditingController) async {
    DateTime? newSelectedDate = await showDatePicker(
        locale: const Locale('en', 'IN'),
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        fieldHintText: 'yyyy/mm/dd',
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: OColors.darkGrey,
                onPrimary: Colors.white,
                surface: OColors.secondary,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: OColors.darGrey,
            ),
            child: child as Widget,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      textEditingController
        ..text = DateFormat('yyyy/MM/dd').format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
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
                                          const CrmPackageAdd()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Add Package', style: header14),
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
                              child: Text('View Package', style: header14),
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
                              child: Text('Booking Orders', style: header14),
                            )),
                      ],
                    ))),
          );
        });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
