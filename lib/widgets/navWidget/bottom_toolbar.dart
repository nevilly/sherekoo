import 'package:flutter/material.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/profileMode.dart';
import '../../screens/categoriesPage/sherekooPage.dart';
import '../../screens/home.dart';
import '../../screens/crmScreen/crmFont.dart';
import '../../screens/profile/profile.dart';
import '../../screens/uploadScreens/uploadSherekoo.dart';

class BottomToolbar extends StatelessWidget {
  static const double navigationIconSize = 30.0;
  static const double createButtonWidth = 35.0;

  BottomToolbar({Key? key}) : super(key: key);

  User currentUser = User(
      id: '',
      username: '',
      avater: '',
      phoneNo: '',
      role: '',
      gender: '',
      email: '',
      firstname: '',
      lastname: '', isCurrentUser: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 20),
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Share
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SherekooUpload()));
                },
                child: Container(
                  width: 49.0,
                  height: 27.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 3.5,
                      ),
                      Text('Share',
                          style: TextStyle(
                            color: OColors.textColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('Koo',
                          style: TextStyle(
                            color: OColors.textColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                )),
            //Search,Ceremony
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CrmFontPage()));
                },
                child: const Icon(Icons.search,
                    color: Colors.white, size: navigationIconSize)),
            // Home
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const Home()));
                },
                child: const Icon(Icons.home,
                    color: Colors.white, size: navigationIconSize)),
            // Categories
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Sherekoo()));
                },
                child: const Icon(Icons.message,
                    color: Colors.white, size: navigationIconSize)),
            //Profile
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Profile(
                                user: User(
                                    id: '',
                                    username: '',
                                    avater: '',
                                    phoneNo: '',
                                    role: '',
                                    gender: '',
                                    email: '',
                                    firstname: '',
                                    lastname: '', isCurrentUser: ''),
                              )));
                },
                child: const Icon(Icons.person,
                    color: Colors.white, size: navigationIconSize))
          ],
        ),
      ),
    );
  }

  Widget get customCreateIcon => SizedBox(
      width: 45.0,
      height: 27.0,
      child: Stack(children: [
        Container(
            margin: const EdgeInsets.only(left: 10.0),
            width: createButtonWidth,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7.0))),
        Container(
            margin: const EdgeInsets.only(right: 10.0),
            width: createButtonWidth,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7.0))),
        Center(
            child: Container(
          height: double.infinity,
          width: createButtonWidth,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
          child: const Icon(
            Icons.add,
            size: 20.0,
          ),
        )),
      ]));
}
