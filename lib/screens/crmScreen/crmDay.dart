import 'package:flutter/material.dart';
import 'package:sherekoo/screens/detailScreen/livee.dart';
import 'package:sherekoo/widgets/imgWigdets/userAvater.dart';

import '../../model/allData.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/ceremony/ceremonyModel.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
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
  List<CeremonyModel> data = [];

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
      meritalStatus: '', totalPost: '');

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
          data = value.payload
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
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.red)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CrmDoor(
                                        crm: data[index],
                                      )));
                        },
                        child: Stack(children: [
                          ClipRRect(
                            child: Center(
                                child: data[index].cImage != ''
                                    ? Img(
                                        avater: data[index].cImage,
                                        url: '/ceremony/',
                                        username: data[index].u1,
                                        width: 145,
                                        height: 150,
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
                                data[index].ceremonyType,
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
                              child: Text(
                                  data[index].ceremonyType.toUpperCase(),
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1)),
                            ),

                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              child: RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                      text: 'On: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Colors.grey)),
                                  TextSpan(
                                      text: data[index].ceremonyDate,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.black))
                                ]),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Livee(
                                              ceremony: data[index],
                                            )));
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(105)),
                                  child: Text(
                                    'Code: ' + data[index].codeNo,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),

                            // Profile Details
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Profile Photo...
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(105)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child:
                                            // check if bday or kigodoro
                                            data[index].ceremonyType ==
                                                        'Birthday' ||
                                                    data[index].ceremonyType ==
                                                        'Kigodoro'
                                                ?
                                                //if avater not empty
                                                data[index].u1Avt.isNotEmpty
                                                    ? UserAvater(
                                                        avater:
                                                            data[index].u1Avt,
                                                        url: '/profile/',
                                                        username:
                                                            data[index].u1,
                                                        height: 35,
                                                        width: 35)
                                                    : const DefaultAvater(
                                                        height: 35,
                                                        radius: 15,
                                                        width: 35)
                                                :

                                                // if birthday is empty must be wedding or send off or kitchn part
                                                data[index].u1Avt.isNotEmpty
                                                    ? UserAvater(
                                                        avater:
                                                            data[index].u1Avt,
                                                        url: '/profile/',
                                                        username:
                                                            data[index].u1,
                                                        height: 35,
                                                        width: 35)
                                                    : const DefaultAvater(
                                                        height: 35,
                                                        radius: 15,
                                                        width: 35)),
                                  ),

                                  data[index].ceremonyType == 'Wedding' ||
                                          data[index].ceremonyType ==
                                              'SendOff' ||
                                          data[index].ceremonyType ==
                                              'Kitchen Part'
                                      ? Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(105)),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: data[index]
                                                      .u2Avt
                                                      .isNotEmpty
                                                  ? UserAvater(
                                                      avater: data[index].u2Avt,
                                                      url: '/profile/',
                                                      username: data[index].u2,
                                                      height: 35,
                                                      width: 35)
                                                  : const DefaultAvater(
                                                      height: 35,
                                                      radius: 15,
                                                      width: 35)),
                                        )
                                      : const SizedBox(),
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
                                          const Icon(
                                            Icons.group,
                                            size: 14,
                                          ),
                                          '1k'),
                                      cardFotter(
                                          const Icon(
                                            Icons.reply,
                                            size: 12,
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
                                  const Icon(
                                    Icons.share,
                                    size: 13,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  data[index].fId == currentUser.id ||
                                          data[index].sId == currentUser.id
                                      ? GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  _buildPopupDialog(
                                                      context, index),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.more_vert,
                                            size: 13,
                                          ),
                                        )
                                      : const SizedBox(),
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
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
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
          style: const TextStyle(fontSize: 12),
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
                            getData: data[index],
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
