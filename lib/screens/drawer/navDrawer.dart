import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/screens/detailScreen/livee.dart';
import 'package:sherekoo/screens/bsnScreen/bsnScrn.dart';

import '../../model/allData.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/util.dart';
import '../accounts/login.dart';
import '../crmScreen/Crm.dart';
import '../crmScreen/crmScreen.dart';
import '../hireRequset/InvCeremony.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final Preferences _preferences = Preferences();
  String token = '';
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
      isCurrentUser: '');

  CeremonyModel ceremony = CeremonyModel(
      cId: '',
      codeNo: '',
      ceremonyType: '',
      cName: '',
      fId: '',
      sId: '',
      cImage: '',
      ceremonyDate: '',
      contact: '',
      admin: '',
      u1: '',
      u1Avt: '',
      u1Fname: '',
      u1Lname: '',
      u1g: '',
      u2: '',
      u2Avt: '',
      u2Fname: '',
      u2Lname: '',
      u2g: '',
      youtubeLink: '');

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        getUser();
      });
    });

    super.initState();
  }

  getUser() async {
    AllUsersModel(payload: [], status: 0).get(token, urlGetUser).then((value) {
      setState(() {
        if (value.status == 200) {
          setState(() {
            currentUser = User.fromJson(value.payload);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: OColors.appBarColor),
                accountName: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    currentUser.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                accountEmail: Text(currentUser.email),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                  api +
                      'public/uploads/' +
                      currentUser.username +
                      '/profile/' +
                      currentUser.avater,
                )),
                onDetailsPressed: () {},
              ),

              //LIve ceremony
              ListTile(
                title: const Text('LIve Ceremony'),
                onTap: () {
                  // Navigator.of(context).pop();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => const LiveEve()));
                },
              ),
              //ceremony
              ListTile(
                title: const Text('All Ceremony'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Crm(dataType: 'all')));
                },
              ),

              //ceremony
              ListTile(
                title: const Text('Ceremony'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CeremonyScreen()));
                },
              ),
              //All Busness
              ListTile(
                title: const Text('Busness'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BusnessScreen(
                                bsnType: 'all',
                                ceremony: ceremony,
                              )));
                },
              ),

              ListTile(
                title: const Text('Mc'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BusnessScreen(
                                bsnType: 'Mc',
                                ceremony: ceremony,
                              )));
                },
              ),

              ListTile(
                title: const Text('Invatation'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const InvatationCeremony(
                                id: 'all',
                              )));
                },
              ),
              // Livee ceremony
              ListTile(
                title: const Text('Livee'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Livee(
                                ceremony: ceremony,
                              )));
                },
              ),

              // ListTile(
              //   title: const Text('Shampeners Dancers'),
              //   onTap: () {
              //     // Navigator.of(context).pop();
              //     // Navigator.push(
              //     //     context,
              //     //     new MaterialPageRoute(
              //     //         builder: (BuildContext context) =>
              //     //             new BusnessDetails()));
              //   },
              // ),

              ListTile(
                title: const Text('Log Out'),
                onTap: () {
                  _preferences.logout();

                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginPage()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
