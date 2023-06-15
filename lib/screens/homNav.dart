import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sherekoo/util/modInstance.dart';

import '../model/user/userModel.dart';
import '../util/app-variables.dart';
import '../util/colors.dart';
import 'categoriesPage/sherekooPage.dart';
import 'home.dart';
import 'profile/profile.dart';
import 'sherekooBundle/sherekoBundle.dart';
import 'uploadScreens/uploadSherekoo.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class HomeNav extends StatefulWidget {
  final dynamic getIndex;
  final User user;

  const HomeNav({Key? key, required this.getIndex, required this.user})
      : super(key: key);

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  String notificationToken = '';

  bool bottom = false,
      noInsights = true,
      isSwitched = false,
      isLoggedIn = false,
      notified = true;

  late String messages = "",
      selected = '',
      category = '',
      username,
      id,
      avatar,
      nodata = '';

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int index = 2;

  final screen = [
    SherekooUpload(from: 'Home', crm: emptyCrmModel),
    // const CrmOnNav(),
    const SherekooBundle(),
    const Home(),
    const Sherekoo()
  ];

  User user = User(
      id: '',
      gId: '',
      urlAvatar: '',
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
    super.initState();
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        if (widget.user.id != '') {
          screen.add(Profile(
              user: User(
                  id: widget.user.id,
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
                  totalLikes: '')));
        } else {
          screen.add(Profile(
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
                  isCurrentUser: '',
                  address: '',
                  bio: '',
                  meritalStatus: '',
                  totalPost: '',
                  isCurrentBsnAdmin: '',
                  isCurrentCrmAdmin: '',
                  totalFollowers: '',
                  totalFollowing: '',
                  totalLikes: '')));
        }
      });
    });

    index = widget.getIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OColors.appBarColor,
      child: ClipRect(
        child: SafeArea(
          top: false,
          child: Scaffold(
            extendBody: true,
            bottomNavigationBar: Theme(
              data: Theme.of(context)
                  .copyWith(iconTheme: IconThemeData(color: OColors.white)),
              child: CurvedNavigationBar(
                key: _bottomNavigationKey,
                index: index,
                height: 50.0,
                items: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.add,
                      size: 25,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.celebration,
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
                      Icons.category,
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
                color: OColors.navBar,
                buttonBackgroundColor: OColors.navBar,
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
