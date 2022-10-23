import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import '../../util/modInstance.dart';
import 'mosq-Profile.dart';
import 'mosq-post.dart';
import 'mosq-timeline.dart';

class MosqProject extends StatefulWidget {
  final dynamic getIndex;
  final User user;

  const MosqProject({Key? key, required this.getIndex, required this.user})
      : super(key: key);

  @override
  State<MosqProject> createState() => _MosqProjectState();
}

class _MosqProjectState extends State<MosqProject> {
  final Preferences _preferences = Preferences();
  String token = "";

  final screen = [
    const MosqPost(),
    const MosqTimeLine(),
  ];

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int index = 2;

  @override
  void initState() {
    super.initState();
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        if (widget.user.id != '') {
          screen.add(MosqProfile(
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
          screen.add(MosqProfile(user: user));
        }
      });
    });

    // index = widget.getIndex;
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
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.home,
                      size: 25,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.person,
                      size: 25,
                    ),
                  ),

                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 8),
                  //   child: const Icon(
                  //     Icons.category,
                  //     size: 25,
                  //   ),
                  // ),

                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 8),
                  //   child: const Icon(
                  //     Icons.perm_identity,
                  //     size: 25,
                  //     color: Colors.white,
                  //   ),
                  // ),
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
