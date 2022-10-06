import 'package:flutter/material.dart';
import 'package:sherekoo/screens/detailScreen/livee.dart';
import 'package:sherekoo/widgets/imgWigdets/userAvater.dart';

import '../../model/allData.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/boxImg.dart';
import '../../widgets/imgWigdets/defaultAvater.dart';
import '../accounts/login.dart';
import '../uploadScreens/ceremonyUpload.dart';
import 'crmDoor.dart';

class CeremonyDay extends StatefulWidget {
  final String day;
  const CeremonyDay({Key? key, required this.day}) : super(key: key);

  @override
  State<CeremonyDay> createState() => _CeremonyDayState();
}

class _CeremonyDayState extends State<CeremonyDay> {
  final Preferences _preferences = Preferences();
  String token = '';
  List<CeremonyModel> crm = [];
  List ourService = [
    'ceremony card',
    'Dressing Design',
    'Production',
    'Birthday Shows',
    'Dating Show'
  ];

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
        getUser();
        getAllCeremony();
      });
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

  getAllCeremony() async {
    AllCeremonysModel(payload: [], status: 0)
        .getDayCeremony(token, urlCrmByDay, widget.day)
        .then((value) {
      // print('alll ceremoniewss');
      if (value.status == 200) {
        // print(value.payload);
        setState(() {
          crm = value.payload
              .map<CeremonyModel>((e) => CeremonyModel.fromJson(e))
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      body: ListView.builder(
        itemCount: crm.length,
        itemBuilder: (BuildContext context, int index) {
          final itm = crm[index];
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              color: OColors.darGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: OColors.primary)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CrmDoor(
                                          crm: crm[index],
                                        )));
                          },
                          child: Stack(children: [
                            ClipRRect(
                              child: Center(
                                  child: itm.cImage != ''
                                      ? Img(
                                          avater: itm.cImage,
                                          url: '/ceremony/',
                                          username: itm.userFid.username!,
                                          width: 145,
                                          height: 145,
                                        )
                                      : const SizedBox(height: 1)),
                            ),

                            // Red TAGs ceremony Type
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 136, 64, 64),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0,
                                    left: 8.0,
                                    right: 13.0,
                                    bottom: 4.0),
                                child: Text(
                                  itm.ceremonyType,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ]),
                        ),

                        //Details Ceremony
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),

                              // Title
                              Container(
                                margin: const EdgeInsets.only(top: 1),
                                child: Text(itm.ceremonyType.toUpperCase(),
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: OColors.fontColor,
                                        letterSpacing: 1)),
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'On: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: OColors.fontColor,
                                        )),
                                    TextSpan(
                                        text: itm.ceremonyDate,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: OColors.fontColor,
                                        ))
                                  ]),
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CrmDoor(
                                                crm: itm,
                                              )));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: OColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(105)),
                                    child: Text(
                                      'Code: ${itm.codeNo}',
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),

                              // Profile Details
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (itm.ceremonyType == 'Wedding')
                                      weddingProfileCrm(
                                          context, itm, 35, 35, 35),
                                    if (itm.ceremonyType == 'Kitchen Part')
                                      kichernPartProfileCrm(
                                          context, itm, 35, 35, 35),
                                    if (itm.ceremonyType == 'Birthday')
                                      birthdayProfileCrm(
                                          context, itm, 35, 35, 35),
                                    if (itm.ceremonyType == 'SendOff')
                                      sendProfileCrm(context, itm, 35, 35, 35),
                                    if (itm.ceremonyType == 'Kigodoro')
                                      kigodoroProfileCrm(
                                          context, itm, 35, 35, 35),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 6.0,
                                    left: 10.0,
                                    right: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        cardFotter(
                                            Icon(
                                              Icons.group,
                                              size: 14,
                                              color: OColors.primary,
                                            ),
                                            '1k'),
                                        cardFotter(
                                            Icon(
                                              Icons.reply,
                                              size: 12,
                                              color: OColors.primary,
                                            ),
                                            '2k'),
                                        cardFotter(
                                            const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 12,
                                            ),
                                            '99+'),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.share,
                                      size: 13,
                                      color: OColors.primary,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    // decoration: BoxDecoration(
                    //     border: Border.all(width: 1, color: OColors.primary),
                    //     borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Text('Booking Now',
                          style:
                              header10.copyWith(fontStyle: FontStyle.italic)),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 4.0, bottom: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: OColors.primary),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 6.0, right: 6),
                                child: Text(
                                  'Ceremony Card',
                                  style: header10,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: OColors.primary),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, right: 4),
                                child: Text(
                                  'Dressing Design',
                                  style: header10,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: OColors.primary),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, right: 4),
                                child: Text(
                                  'Production',
                                  style: header10,
                                ),
                              ),
                            ),
                          ],
                       
                        ),
                        if (itm.fId == currentUser.id ||
                            itm.sId == currentUser.id)
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context, index),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.more_vert,
                                size: 13,
                                color: OColors.fontColor,
                              ),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row check(CeremonyModel itm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        itm.userFid.avater!.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     OColors.primary2,
                    //     OColors.darGrey,
                    //     OColors.fontColor,
                    //     // OColors.darGrey,
                    //     OColors.primary2,
                    //     OColors.darGrey,
                    //     OColors.primary,
                    //   ],
                    // ),
                    // borderRadius: BorderRadius.circular(20),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                    child: UserAvater(
                        avater: itm.userFid.avater!,
                        url: '/profile/',
                        username: itm.userFid.username!,
                        height: 35,
                        width: 35),
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     OColors.primary2,
                    //     OColors.darGrey,
                    //     OColors.fontColor,
                    //     // OColors.darGrey,
                    //     OColors.primary2,
                    //     OColors.darGrey,
                    //     OColors.primary,
                    //   ],
                    // ),
                    // borderRadius: BorderRadius.circular(20),
                    ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                    child: DefaultAvater(height: 35, radius: 35, width: 35)),
              ),
        itm.userSid.avater!.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     // OColors.primary2,
                    //     // OColors.darGrey,
                    //     // OColors.fontColor,
                    //     // // OColors.darGrey,
                    //     // OColors.primary2,
                    //     // OColors.darGrey,
                    //     // OColors.primary,
                    //   ],
                    // ),
                    // borderRadius: BorderRadius.circular(20),
                    ),
                child: Container(
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     colors: [
                  //       OColors.primary2,
                  //       OColors.darGrey,
                  //       OColors.fontColor,
                  //       // OColors.darGrey,
                  //       OColors.primary2,
                  //       OColors.darGrey,
                  //       OColors.primary,
                  //     ],
                  //   ),
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                      child: UserAvater(
                          avater: itm.userSid.avater!,
                          url: '/profile/',
                          username: itm.userSid.username!,
                          height: 35,
                          width: 35),
                    ),
                  ),
                ),
              )
            : Container(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                      child: DefaultAvater(height: 35, radius: 35, width: 35)),
                ),
              ),
      ],
    );
  }

  Row cardFotter(Icon icon, String no) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 2,
        ),
        Text(
          no,
          style: TextStyle(color: OColors.fontColor, fontSize: 12),
        ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }

  Widget _buildPopupDialog(BuildContext context, index) {
    return AlertDialog(
      title: const Text('Ceremony Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Editing Update'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CeremonyUpload(
                            getData: crm[index],
                            getcurrentUser: currentUser,
                          )));
            },
          ),
          ListTile(
            title: const Text('hide your ceremony'),
            onTap: () {
              _preferences.logout();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()));
            },
          ),
          ListTile(
            title: const Text('Only you see ceremony'),
            onTap: () {
              _preferences.logout();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()));
            },
          ),
          ListTile(
            title: const Text('Delete ceremony'),
            onTap: () {
              _preferences.logout();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()));
            },
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          // Color: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
