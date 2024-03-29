import 'package:flutter/material.dart';
import 'package:sherekoo/model/follow/followCall.dart';
import 'package:sherekoo/screens/profile/myCrmn.dart';
import 'package:sherekoo/screens/profile/viewFollowers.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/util/modInstance.dart';
import 'package:sherekoo/widgets/imgWigdets/defaultAvater.dart';
import '../../model/user/user-call.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/func.dart';
import '../../util/pallets.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';
import '../accounts/login.dart';
import '../drawer/navDrawer.dart';
import '../settingScreen/settings.dart';
import '../uploadScreens/busnessUpload.dart';
import '../uploadScreens/ceremonyUpload.dart';
import 'bsn-admn.dart';
import 'crm-admin.dart';
import 'myPosts.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}

class ProfileState extends State<Profile> {
  TextStyle styl =
      header13.copyWith(fontWeight: FontWeight.bold, color: OColors.primary);
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
      whatYouDo: '',
      followInfo: '',
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      currentFllwId: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        print(widget.user.id);
        widget.user.id != ''
            ? getUser('$urlGetUser/${widget.user.id}')
            : getUser(urlGetUser);
      });
    });

    super.initState();
  }

  Future getUser(String dirUrl) async {
    return await UsersCall(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          user = User.fromJson(value.payload);
        });
      }
    });
  }

  addfollowSyst(id, urlDr, String typ) {
    FollowCall(payload: [], status: 0).follow(token, urlDr, id).then((value) {
      if (value.status == 200) {
        setState(() {
          user.followInfo = 'unfollow';
          int incFolower = int.parse(user.totalFollowers!) + 1;
          user.totalFollowers = incFolower.toString();
        });
      }
    });
  }

  unfollowSyst(id, urlDr, String typ) {
    FollowCall(payload: [], status: 0).follow(token, urlDr, id).then((value) {
      if (value.status == 200) {
        setState(() {
          user.followInfo = 'Follow';
          int incFolower = int.parse(user.totalFollowers!) - 1;
          user.totalFollowers = incFolower.toString();
        });
      }
    });
  }

  followbackSyst(id, urlDr, String typ) {
    FollowCall(payload: [], status: 0).follow(token, urlDr, id).then((value) {
      if (value.status == 200) {
        setState(() {
          user.followInfo = 'unfollow';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: OColors.secondary,
        appBar: AppBar(
          backgroundColor: OColors.secondary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              user.username!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${user.username!.substring(0, 3).toUpperCase()}..',
                        style: h3,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: OColors.secondary, strokeWidth: 2.0),
                      ),
                    ),
              const SizedBox(
                width: 2,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(Icons.keyboard_arrow_down),
              )
            ],
          ),
          centerTitle: true,
          actions: [
            const NotifyWidget(),
            const SizedBox(
              width: 5,
            ),

            ///
            /// Settings
            ///
            user.isCurrentUser == true
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            profileSettings(context),
                      );

                      // PopupMenuButton<MenuItem>(
                      //     onSelected: (value) {
                      //       if (value == MenuItem.item1) {
                      //         print('execute func item1');
                      //       }
                      //     },
                      //     itemBuilder: (context) => [
                      //           PopupMenuItem(
                      //               enabled: true,
                      //               value: MenuItem.item1,
                      //               child: const Text('Delete')),
                      //           PopupMenuItem(
                      //             enabled: true,
                      //             value: MenuItem.item2,
                      //             child: const Text('report contet'),
                      //           ),
                      //         ]);
                    },
                    child: Container(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: const Icon(Icons.more_vert)),
                  )
                : SizedBox.shrink(),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        drawer: const NavDrawer(),
        body: Column(
          children: [
            //Profile
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 5.0, right: 8.0),
              child: topProfile(),
            ),

            const SizedBox(height: 18),

            //button edit Profile
            IntrinsicHeight(child: profileDetails(context)),

            const SizedBox(
              height: 10,
            ),

            user.isCurrentUser == true
                ? GestureDetector(
                    onTap: () {
                      showAlertDialog(context, 'Admin', '', '', '');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6.0, bottom: 6.0, left: 20, right: 20),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: OColors.primary),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings_suggest,
                                color: OColors.primary,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              user.isCurrentBsnAdmin == true ||
                                      user.isCurrentCrmAdmin
                                  ? Text(
                                      'Admin',
                                      style:
                                          h4.copyWith(color: OColors.primary),
                                    )
                                  : Text(
                                      'Create',
                                      style:
                                          h4.copyWith(color: OColors.primary),
                                    ),
                            ],
                          )),
                    ),
                  )
                : const SizedBox(),
            //default tab Controller
            TabBar(
                labelColor: OColors.primary,
                indicatorColor: OColors.primary,
                unselectedLabelColor: OColors.darkGrey,
                tabs: const [
                  Tab(
                      icon: Icon(
                    Icons.grid_on_outlined,
                    size: 20,
                  )),
                  Tab(
                    icon: Icon(
                      Icons.celebration,
                      size: 25,
                    ),
                  ),
                  // Tab(
                  //   icon: Icon(
                  //     Icons.add_business,
                  //     size: 25,
                  //   ),
                  // ),
                ]),

            Expanded(
              child: TabBarView(children: [
                // My Posts

                user.id!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 10, right: 10),
                        child: MyPosts(
                          user: user,
                        ),
                      )
                    : loadingFunc(40, OColors.primary),

                // My Ceremonies
                user.id!.isNotEmpty
                    ? MyCrmn(
                        userId: user.id!,
                      )
                    : loadingFunc(40, OColors.primary),

                // user.id!.isNotEmpty
                //     ? MyBusness(
                //         user: user,
                //       )
                //     : loadingFunc(40, OColors.primary),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Profile Functions
  ///

  Row topProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Row(
            children: [
              //Avater
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: OColors.secondary,
                ),
                child: user.avater != ''
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: OColors.darGrey,
                          radius: 45,
                          child: ClipOval(
                            child: profilefadeImg(context,
                                api + user.urlAvatar!, 85.0, 85.0, BoxFit.fill),
                          ),
                        ))
                    : CircleAvatar(
                        backgroundColor: OColors.darGrey,
                        radius: 50,
                        child: const ClipOval(
                            child: DefaultAvater(
                                height: 85, radius: 55, width: 85)),
                      ),
              ),

              //username && Followers
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Username
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '@${user.username}',
                        style: header14,
                      ),
                    ),

                    //Fan
                    Text(
                      user.whatYouDo!,
                      style: h5,
                    ),

                    //Follow
                    user.isCurrentUser == false
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (user.followInfo! == 'Follow') {
                                    addfollowSyst(
                                        user.id, urlAddFollow, 'addFollow');
                                  }

                                  if (user.followInfo! == 'unfollow') {
                                    unfollowSyst(user.currentFllwId,
                                        urlUnFollow, 'unfollow');
                                  }

                                  if (user.followInfo! == 'followback') {
                                    followbackSyst(user.currentFllwId,
                                        urlUnFollowback, 'followback');
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 6),
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      if (user.followInfo! == 'Follow')
                                        Text('Follow + ', style: styl),
                                      if (user.followInfo! == 'unfollow')
                                        Text('Unfollow', style: styl),
                                      if (user.followInfo! == 'followback')
                                        Text('followback', style: styl),
                                      if (user.followInfo! == 'false')
                                        const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  /// Profile Settings
  ///

  Row profileDetails(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Text(user.totalPost!,
                  style: h4.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 1),
              Text(
                'Posts',
                style: header10,
              ),
            ],
          ),
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ViewFollowers(
                          typ: 'followers',
                          usrId: user.id!,
                          isCurrent: user.isCurrentUser,
                        )));
          },
          child: Column(
            children: [
              Text(user.totalFollowers!,
                  style: h4.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 1),
              Text(
                'Followers',
                style: header10,
              ),
            ],
          ),
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ViewFollowers(
                          typ: 'following',
                          usrId: user.id!,
                          isCurrent: user.isCurrentUser,
                        )));
          },
          child: Column(
            children: [
              Text(user.totalFollowing!,
                  style: h4.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 1),
              Text(
                'Following',
                style: header10,
              ),
            ],
          ),
        ),

        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),

        //Like Container
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Text(user.totalLikes!,
                  style: h4.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 1),
              Text(
                'Likes',
                style: header10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  /// PopUp Widget
  ///

  Widget profileSettings(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.only(left: 5),
      backgroundColor: osec,
      title: Text(
        'Profile Settings',
        style: header18,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            textColor: OColors.fontColor,
            leading: Icon(Icons.settings, color: fntClr),
            title: const Text('Updata profile'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProfileSetting(user: user)));
            },
          ),
          ListTile(
            textColor: OColors.fontColor,
            leading: Icon(Icons.logout, color: fntClr),
            title: const Text('Logout'),
            onTap: () {
              preferences.logout();
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()));
            },
          ),
        ],
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                color: prmry,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Close',
                  style: header12.copyWith(fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ],
    );
  }

  ///
  /// Alert Widget
  ///
  showAlertDialog(
      BuildContext context, String title, String msg, req, String from) async {
    // set up the buttons
    Widget busnessButton = user.isCurrentBsnAdmin == true
        ? TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(6),
              primary: OColors.fontColor,
              backgroundColor: OColors.primary,
              // textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            child: Text("Busness", style: header13),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => BSnAdminPage(
                            user: user,
                          )));
            },
          )
        : TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(6),
              primary: OColors.fontColor,
              backgroundColor: OColors.primary,
              // textStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            child: Text("Busness +", style: header13),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => BusnessUpload(
                            getData: emptyBsnMdl,
                          )));
            },
          );

    Widget ceremonyButton = user.isCurrentCrmAdmin == true
        ? TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(6),
              primary: OColors.fontColor,
              backgroundColor: OColors.primary,
            ),
            child: Text(
              "Ceremony",
              style: header13,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AdminPage(
                            from: 'Crm',
                            user: user,
                          )));
            },
          )
        : TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(6),
              primary: OColors.fontColor,
              backgroundColor: OColors.primary,
            ),
            child: Text(
              "Ceremony +",
              style: header13,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CeremonyUpload(
                          getData: CeremonyModel(
                            cId: '',
                            codeNo: '',
                            ceremonyType: '',
                            cName: '',
                            fId: '',
                            sId: '',
                            cImage: '',
                            ceremonyDate: '',
                            admin: '',
                            contact: '',
                            isInFuture: '',
                            isCrmAdmin: '',
                            likeNo: '',
                            chatNo: '',
                            viwersNo: '',
                            userFid: User(
                                id: '',
                                username: '',
                                firstname: '',
                                lastname: '',
                                avater: '',
                                phoneNo: '',
                                email: '',
                                gender: '',
                                role: '',
                                address: '',
                                meritalStatus: '',
                                bio: '',
                                totalPost: '',
                                isCurrentUser: '',
                                isCurrentCrmAdmin: '',
                                isCurrentBsnAdmin: '',
                                totalFollowers: '',
                                totalFollowing: '',
                                totalLikes: ''),
                            userSid: User(
                                id: '',
                                username: '',
                                firstname: '',
                                lastname: '',
                                avater: '',
                                phoneNo: '',
                                email: '',
                                gender: '',
                                role: '',
                                address: '',
                                meritalStatus: '',
                                bio: '',
                                totalPost: '',
                                isCurrentUser: '',
                                isCurrentCrmAdmin: '',
                                isCurrentBsnAdmin: '',
                                totalFollowers: '',
                                totalFollowing: '',
                                totalLikes: ''),
                            youtubeLink: '',
                          ),
                          getcurrentUser: user)));
            },
          );

    Widget setting = Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.settings,
          color: OColors.primary,
          size: 20,
        ));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: OColors.secondary,
      title: Center(
        child: Text(title, style: TextStyle(color: OColors.fontColor)),
      ),
      actions: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                busnessButton,
                ceremonyButton,
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(onTap: () {}, child: setting),
              ],
            ),
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
