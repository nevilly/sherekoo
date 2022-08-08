import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../model/allData.dart';
import '../model/profileMode.dart';
import '../util/Preferences.dart';
import '../util/util.dart';
import 'categoriesPage/sherekooPage.dart';
import 'crmScreen/crmFont.dart';
import 'home.dart';
import 'profile/profile.dart';
import 'uploadScreens/uploadSherekoo.dart';

class HomeNav extends StatefulWidget {
  final dynamic getIndex;
  final User user;

  const HomeNav({Key? key, required this.getIndex, required this.user})
      : super(key: key);

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  final Preferences _preferences = Preferences();
  String token = '';

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int index = 2;

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
      isCurrentUser: '');

  final screen = [
    const SherekooUpload(),
    const CrmFontPage(),
    const Home(),
    const Sherekoo(),
    Profile(
        user: User(
            id: '',
            username: '',
            firstname: '',
            lastname: '',
            avater: '',
            phoneNo: '',
            email: '',
            gender: '',
            role: '',
            isCurrentUser: '')),
  ];

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;

        widget.user.id != ''
            ? getUser(urlGetUser + '/' + widget.user.id)
            : getUser(urlGetUser);
      });
    });
    index = widget.getIndex;
    super.initState();
  }

  getUser(arg) async {
    AllUsersModel(payload: [], status: 0).get(token, arg).then((value) {
      if (value.status == 200) {
        setState(() {
          user = User.fromJson(value.payload);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: ClipRect(
        child: SafeArea(
          top: false,
          child: Scaffold(
            extendBody: true,
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  iconTheme: const IconThemeData(color: Colors.white)),
              child: CurvedNavigationBar(
                key: _bottomNavigationKey,
                index: index,
                height: 35.0,
                items: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.upload,
                      size: 25,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 25,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.home,
                      size: 25,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.list,
                      size: 25,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.perm_identity,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
                color: Colors.black87,
                buttonBackgroundColor: Colors.black87,
                backgroundColor: Colors.transparent,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 500),
                onTap: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
                letIndexChange: (index) => true,
              ),
            ),
            body: screen[index],
          ),
        ),
      ),
    );
  }
}
