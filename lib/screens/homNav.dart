import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';

import '../model/profileMode.dart';
import '../model/token.dart';
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
    notificationInit();

    // FirebaseMessaging.instance
    //     .getToken(vapidKey: "1:780741266478:android:cadcf8f94da2a4151f63bf")
    //     .then((value) {
    //   setState(() {
    //     notificationToken = value!;
    //     // print('notificationToken');
    //     // print(notificationToken);
    //   });
    // });

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
                  meritalStatus: '')));
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
                  bio: '')));
        }
      });
    });

    index = widget.getIndex;
    super.initState();
  }

  notificationInit() async {
    /*await notification.init().then((value) {
      if (mounted)
        setState(() {
          token = value;
        });

      // session.add("token", token);
      // if (notified) {
      //   _firebaseMessaging.configure(
      //     onMessage: (Map<String, dynamic> message) async {
      //       //print("onMessage: $message");
      //       //print("token:$token");
      //       _showItemDialog(
      //           message: message['notification']['body'],
      //           action: message['data']['click_action'],
      //           id: message['data']['id']);
      //     },
      //     onBackgroundMessage: myBackgroundMessageHandler,
      //     onLaunch: (Map<String, dynamic> message) async {
      //       //print("onLaunch: $message");
      //       //print("onLaunch:"+message['data']);
      //       _navigateToItemDetail(
      //           action: message['data']['click_action'],
      //           id: message['data']['id'],
      //           url: message['data']['url']);
      //     },
      //     onResume: (Map<String, dynamic> message) async {
      //       //print("onResume: $message");
      //       //print("onResume:"+message['data']);
      //       _navigateToItemDetail(
      //           action: message['data']['click_action'],
      //           id: message['data']['id'],
      //           url: message['data']['url']);
      //     },
      //   );
      // }

      addToken();
    });
  */
  }

  sessionInit() {
    Preferences().init().then((data) {
      if (mounted) {
        setState(() {
          username = data.getString('username');
          id = data.getString('id');
          // print(username);
          avatar = data.getString('avatar');
          var n = data.getString('notified');
          notified = (n != null && n == 'yes');
          String lang = data.getString('language');
          // print(n);
          isLoggedIn = username.isNotEmpty ? true : false;
          // isSwahili = lang == "Kiswahili";
          // if (!isLoggedIn) {
          //   username =
          //       Locales(type: isSwahili ? 'sw' : 'en', word: 'guest').language;
          // }

          avatar =
              "https://images.vexels.com/media/users/3/129733/isolated/preview/a558682b158debb6d6f49d07d854f99f-casual-male-avatar-silhouette-by-vexels.png";
        });
      }
    });
  }

  Future<Null> addToken() async {
    await TokenManager(token: token, id: '', page: 'add-token')
        .set('API2')
        .then((value) => null);
    return null;
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
