import 'package:flutter/material.dart';
import 'package:sherekoo/screens/detailScreen/livee.dart';
import 'package:sherekoo/screens/bsnScreen/bsn-screen.dart';
import 'package:sherekoo/screens/homNav.dart';
import 'package:sherekoo/screens/ourServices/sherekoCards.dart';

import '../../model/user/user-call.dart';
import '../../model/user/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../accounts/login.dart';
import '../bundles/hotBundle.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final Preferences _preferences = Preferences();
  String token = '';
  double wdt = 8;
  Color oclr = prmry;

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
    UsersCall(payload: [], status: 0).get(token, urlGetUser).then((value) {
      setState(() {
        if (value.status == 200) {
          setState(() {
            user = User.fromJson(value.payload);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // width: 220,
      backgroundColor: OColors.darGrey,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: OColors.secondary),
                accountName: Text(
                  user.username!,
                  style: header18,
                ),
                accountEmail: Text(user.email!),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                  '${api}${user.urlAvatar}',
                )),
                onDetailsPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomeNav(getIndex: 4, user: user)));
                },
              ),

              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: oclr,
                    ),
                    SizedBox(
                      width: wdt,
                    ),
                    Text(
                      'Hot bundle',
                      style: header15,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HotBundles(user: user)));
                },
              ),

              //LIve ceremony

              // ListTile(
              //   title: Text(
              //     'Home',
              //     style: header15,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (BuildContext context) =>
              //                 HomeNav(getIndex: 2, user: user)));
              //   },
              // ),

              //LIve ceremony
              // ListTile(
              //   title: Text(
              //     'Live',
              //     style: header15,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (BuildContext context) => Livee(
              //                   ceremony: emptyCrmModel,
              //                 )));
              //   },
              // ),

              //All Busness
              ListTile(
                title: Text(
                  'Busness',
                  style: header15,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BusnessScreen(
                                bsnType: 'all',
                                ceremony: emptyCrmModel,
                              )));
                },
              ),

              // ListTile(
              //   title: const Text('Mc'),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (BuildContext context) => BusnessScreen(
              //                   bsnType: 'Mc',
              //                   ceremony: ceremony,
              //                 )));
              //   },
              // ),
              // ListTile(
              //   title: Text(
              //     'Ceremony',
              //     style: header15,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (BuildContext context) =>
              //                 const CeremonyScreen()));
              //   },
              // ),
              //ceremony
              // ListTile(
              //   title: Text('leter use Ceremony...', style: header15),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (BuildContext context) =>
              //                 const Crm(dataType: 'all')));
              //   },
              // ),

              ListTile(
                title: Text(
                  'Invatation cards',
                  style: header15,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SherekoCards(
                                crm: emptyCrmModel,
                                user: user,
                              )));
                },
              ),

              // Livee ceremony
              ListTile(
                title: Text(
                  'Sherekoo Tv show',
                  style: header15,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Livee(
                                ceremony: emptyCrmModel,
                              )));
                },
              ),

              ListTile(
                title: Text(
                  'Mshenga TvShow',
                  style: header15,
                ),
                onTap: () {
                  // Navigator.of(context).pop();
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             new BusnessDetails()));
                },
              ),
            ],
          ),
          ListTile(
            title: Text(
              'Log Out',
              style: header15,
            ),
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
    );
  }
}
