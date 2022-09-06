import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';

import '../model/profileMode.dart';
import '../util/Preferences.dart';
import '../util/colors.dart';
import 'categoriesPage/sherekooPage.dart';
import 'crmScreen/crmOn-nav.dart';
import 'home.dart';
import 'profile/profile.dart';
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
  final Preferences _preferences = Preferences();
  String token = '', notificationToken = '';

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
    SherekooUpload(
        from: 'Home',
        crm: CeremonyModel(
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
            youtubeLink: '')),
    const CrmOnNav(),
    const Home(),
    const Sherekoo()
  ];

  @override
  void initState() {
 

    _preferences.init();
    _preferences.get('token').then((value) {
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
                  meritalStatus: '', totalPost: '')));
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
                  meritalStatus: '',
                  address: '',
                  bio: '', totalPost: '')));
        }
      });
    });

    index = widget.getIndex;
    super.initState();
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
                      Icons.live_tv,
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
                color: OColors.secondary,
                buttonBackgroundColor: OColors.secondary,
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
