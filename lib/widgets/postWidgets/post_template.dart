// ignore_for_fiefer_typing_uninitialized_variables

// ignore_for_file: prefer_typing_uninitialized_variables, unused_field

import 'package:flutter/material.dart';
import 'package:sherekoo/model/ceremony/ceremonyModel.dart';
import 'package:sherekoo/screens/chats.dart';
import 'package:sherekoo/screens/profile/profile.dart';
import 'package:sherekoo/util/util.dart';

import '../../model/allData.dart';
import '../../model/ceremony/allCeremony.dart';
import '../../model/profileMode.dart';
import '../../screens/detailScreen/livee.dart';
import '../imgWigdets/defaultAvater.dart';
import '../../util/Preferences.dart';
import '../../util/button.dart';

class PostTemplate extends StatefulWidget {
  final String postId;
  final String avater;
  final String userId; //post Creator
  final String username;
  final String videoDescription;
  final String numberOfLikes;
  final String numberOfComments;
  final String numberOfShere;
  final String ceremonyId;

  final filterBck;
  final userPost;

  // ignore: use_key_in_widget_constructors
  const PostTemplate(
      {required this.postId,
      required this.numberOfComments,
      required this.numberOfLikes,
      required this.numberOfShere,
      required this.filterBck,
      required this.avater,
      required this.userPost,
      required this.userId,
      required this.username,
      required this.videoDescription,
      required this.ceremonyId});

  @override
  _PostTemplateState createState() => _PostTemplateState();
}

class _PostTemplateState extends State<PostTemplate> {
  final Preferences _preferences = Preferences();

  String token = '';
  // Full dimensions of an action
  static const double actionWidgetSize = 60.0;

// The size of the icon showen for Social Actions

  static const double actionIconSize = 35.0;

// The size of the share social icon
  static const double shareActionIconSize = 25.0;

// The size of the profile image in the follow Action
  static const double profileImageSize = 50.0;

// The size of the plus icon under the profile image in follow action
  static const double plusIconSize = 20.0;

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
      u2g: '');

  User postUser = User(
      id: '',
      username: '',
      avater: '',
      phoneNo: '',
      role: '',
      gender: '',
      email: '',
      firstname: '',
      lastname: '');

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        if (widget.ceremonyId != '0') {
          getAllCeremony();
        }

        //
        // getUser();
      });
    });

    super.initState();
  }

  getUser() async {
    AllUsersModel(payload: [], status: 0)
        .getUserById(token, urlUserById, widget.userId)
        .then((value) {
      setState(() {
        postUser = User.fromJson(value.payload);
      });
    });
  }

  getAllCeremony() async {
    AllCeremonysModel(payload: [], status: 0)
        .getCeremonyById(token, urlGetCeremonyById, widget.ceremonyId)
        .then((value) {
      setState(() {
        ceremony = CeremonyModel.fromJson(value.payload);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.blue,
          body: Stack(
        children: [
          //back Image filter
          widget.filterBck,

          // User post(Image /Vedeo)
          widget.userPost,

          //Username & Caption
          bodyPanel(context),

          Padding(
            padding: const EdgeInsets.only(bottom: 0, right: 1.0),
            child: Container(
              color: Colors.transparent,
              alignment: const Alignment(1, 1),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                //User Avater
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Profile(
                                    user: User(
                                        id: widget.userId,
                                        username: widget.username,
                                        avater: widget.avater,
                                        phoneNo: '',
                                        role: '',
                                        gender: '',
                                        email: '',
                                        firstname: '',
                                        lastname: ''),
                                  )));
                    },
                    child: _getFollowAction(pictureUrl: widget.avater)),

                // Ceremony Avater exist
                if (widget.ceremonyId != '0') _getCeremonyAvater,

                const SizedBox(
                  height: 8,
                ),

                // Like Button
                MyButton(icon: Icons.favorite, number: widget.numberOfLikes),

                const SizedBox(
                  height: 10,
                ),

                // chats Buttons
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PostChats(
                                    postId: widget.postId,
                                  )));
                    },
                    child: MyButton(
                        icon: Icons.chat_bubble,
                        number: widget.numberOfComments)),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                    icon: Icons.reply_rounded, number: widget.numberOfShere),
                const SizedBox(
                  height: 4,
                ),
              ]),
            ),
          ),
        ],
      )),
    );
  }

  // User body
  Column bodyPanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(.2),
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(15)),
          ),
          width: MediaQuery.of(context).size.width / 1.2,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 8.0, bottom: 8.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Username info
                Text('@ ' + widget.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white)),
                const SizedBox(
                  height: 5,
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: widget.videoDescription,
                        style: const TextStyle(fontSize: 12.0)),
                    // const TextSpan(
                    //     text: ' @ koosafi',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold, fontSize: 12.0)),
                  ])),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  LinearGradient get musicGradient => const LinearGradient(colors: [
        Color(0xFF424242),
        Color(0xFF212121),
        Color(0xFF212121),
        Color(0xFF424242)
      ], stops: [
        0.0,
        0.4,
        0.6,
        1.0
      ], begin: Alignment.bottomLeft, end: Alignment.topRight);

  Widget _getFollowAction({required String pictureUrl}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        width: 60.0,
        height: 60.0,
        child: Stack(children: [_getProfilePicture(), _getPlusIcon()]));
  }

  Widget _getProfilePicture() {
    return Positioned(
        left: (actionWidgetSize / 2) - (profileImageSize / 2),
        child: Container(
          padding: const EdgeInsets.all(
              1.0), // Add 1.0 point padding to create border
          height: profileImageSize, // ProfileImageSize = 50.0;
          width: profileImageSize, // ProfileImageSize = 50.0;

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(profileImageSize / 2)),

          child: widget.avater.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(api +
                      'public/uploads/' +
                      widget.username +
                      '/profile/' +
                      widget.avater),
                )
              : const DefaultAvater(
                  height: profileImageSize,
                  radius: 15,
                  width: profileImageSize),
        ));
  }

  Widget _getPlusIcon() {
    return Positioned(
      bottom: 0,
      left: ((actionWidgetSize / 2) - (plusIconSize / 2)),
      child: Container(
          width: plusIconSize, // PlusIconSize = 20.0;
          height: plusIconSize, // PlusIconSize = 20.0;
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 43, 84),
              borderRadius: BorderRadius.circular(15.0)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 20.0,
          )),
    );
  }

  Widget get _getCeremonyAvater {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Livee(
                      ceremony: ceremony,
                    )));
      },
      child: SizedBox(
          // margin: const EdgeInsets.only(top: 10.0),
          width: actionWidgetSize,
          height: actionWidgetSize,
          child: Column(children: [
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: profileImageSize,
              width: profileImageSize,
              decoration: BoxDecoration(
                  gradient: musicGradient,
                  borderRadius: BorderRadius.circular(profileImageSize / 2)),
              child: ceremony.cImage != ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(19),
                      child: Image.network(
                        api +
                            'public/uploads/' +
                            ceremony.u1 +
                            '/ceremony/' +
                            ceremony.cImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(height: 1),
              // backgroundImage: NetworkImage('https://i.pravatar.cc/300')
            ),
          ])),
    );
  }
}
