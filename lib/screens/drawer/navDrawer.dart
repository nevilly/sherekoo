import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/screens/detailScreen/livee.dart';
import 'package:sherekoo/screens/bsnScreen/bsnScrn.dart';
import 'package:sherekoo/screens/homNav.dart';
import 'package:sherekoo/screens/ourServices/sherekoCards.dart';

import '../../model/allData.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/modInstance.dart';
import '../../util/util.dart';
import '../accounts/login.dart';
import '../crmScreen/Crm.dart';
import '../crmScreen/crmScreen.dart';
import '../hireRequset/InvCeremony.dart';
import '../mosq/mosq-Home.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final Preferences _preferences = Preferences();
  String token = '';

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
            user = User.fromJson(value.payload);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: OColors.darGrey,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: OColors.appBarColor),
                accountName: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    user.username!,
                    style: header18,
                  ),
                ),
                accountEmail: Text(user.email!),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                  '${api}public/uploads/${user.username}/profile/${user.avater}',
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

              //LIve ceremony
              ListTile(
                title: Text(
                  'Mosq Project',
                  style: header15,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MosqProject(
                                getIndex: 1,
                                user: user,
                              )));
                },
              ),

              //LIve ceremony
              ListTile(
                title: Text(
                  'Home',
                  style: header15,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomeNav(getIndex: 2, user: user)));
                },
              ),
              //LIve ceremony
              ListTile(
                title: Text(
                  'Live',
                  style: header15,
                ),
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
                                ceremony: ceremony,
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
              ListTile(
                title: Text(
                  'Ceremony',
                  style: header15,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CeremonyScreen()));
                },
              ),
              //ceremony
              ListTile(
                title: Text('leter use Ceremony...', style: header15),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Crm(dataType: 'all')));
                },
              ),

              ListTile(
                title: Text(
                  'Invatation',
                  style: header15,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SherekoCards(
                                crm: ceremony,
                                user: user,
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
