import 'package:flutter/material.dart';
import 'package:sherekoo/screens/profile/myCrmn.dart';
import 'package:sherekoo/util/colors.dart';
import 'package:sherekoo/widgets/imgWigdets/defaultAvater.dart';
import '../../model/allData.dart';
import '../../model/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/func.dart';
import '../../util/pallets.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/userAvater.dart';
import '../accounts/login.dart';
import '../drawer/navDrawer.dart';
import '../settingScreen/settings.dart';
import 'admin.dart';
import 'myBusness.dart';
import 'myPosts.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final Preferences _preferences = Preferences();
  String token = '';

  late User user = User(
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
        widget.user.id != ''
            ? getUser('$urlGetUser/${widget.user.id}')
            : getUser(urlGetUser);
      });
    });

    super.initState();
  }

  Future getUser(String dirUrl) async {
    return await AllUsersModel(payload: [], status: 0)
        .get(token, dirUrl)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          user = User.fromJson(value.payload);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: OColors.secondary,
        appBar: topBar(),
        drawer: const NavDrawer(),
        body: Column(
          children: [
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
                      showAlertDialog(context, 'Admin',
                          'Are SURE you want remove ..??', '', '');
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
                                  : const Text('Create'),
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
                  // Tab(
                  //     icon: Icon(
                  //   Icons.photo,
                  //   size: 20,
                  // )),
                  Tab(
                    icon: Icon(
                      Icons.celebration,
                      size: 25,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.add_business,
                      size: 25,
                    ),
                  ),
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

                // const Text('Photooos'),
                // My Ceremonies
                user.id!.isNotEmpty
                    ? MyCrmn(
                        userId: user.id!,
                      )
                    : loadingFunc(40, OColors.primary),
                user.id!.isNotEmpty
                    ? MyBusness(
                        user: user,
                      )
                    : loadingFunc(40, OColors.primary),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  AppBar topBar() {
    return AppBar(
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
        // Notification
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );
          },
          child: Container(
              padding: const EdgeInsets.only(right: 8.0),
              child: const Icon(Icons.settings)),
        ),

        const SizedBox(
          width: 5,
        ),
      ],
    );
  }

  // Profile Functions
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
                    ?
                    // User Current Avater
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipOval(
                          child: UserAvater(
                            avater: user.avater!,
                            url: '/profile/',
                            username: user.username!,
                            width: 85.0,
                            height: 85.0,
                          ),
                        ))
                    : const ClipOval(
                        child:
                            DefaultAvater(height: 85, radius: 35, width: 85)),
              ),

              //username && Followers
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Username
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '@${user.username}',
                      style: header18,
                    ),
                  ),

                  //Fan
                  const Padding(
                    padding: EdgeInsets.only(left: 18.0, top: 4),
                    child: Text(
                      '~ Mc & Comedian',
                      style: h5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        //Likes
        user.isCurrentUser == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: const [
                        // Text('34',
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 20)),
                        // SizedBox(
                        //   height: 5.0,
                        // ),
                        Text(' Follow + ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox()
      ],
    );
  }

  // Profile Settings
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
              const Text(
                'Posts',
                style: h5,
              ),
            ],
          ),
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),
        Column(
          children: [
            Text('243', style: h4.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 1),
            const Text(
              'Followers',
              style: h5,
            ),
          ],
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),
        Column(
          children: [
            Text('243', style: h4.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 1),
            const Text(
              'Following',
              style: h5,
            ),
          ],
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
              Text('243', style: h4.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 1),
              const Text(
                'Likes',
                style: h5,
              ),
            ],
          ),
        ),
      ],
    );
  }

// PopUp Widget
  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Our Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Updata Avater'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProfileSetting(user: user)));
            },
          ),
          ListTile(
            title: const Text('Profile Update'),
            onTap: () {
              // Navigator.of(context).pop();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => EditProfile(
              //               data: currentUser,
              //             )));
            },
          ),
          ListTile(
            title: const Text('Log Out'),
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
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          // Color: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

// Alert Widget
  showAlertDialog(
      BuildContext context, String title, String msg, req, String from) async {
    // set up the buttons
    Widget ceremonyButton = TextButton(
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
                builder: (BuildContext context) => AdminPage(
                      from: 'Bsn',
                      user: user,
                    )));
      },
    );
    Widget busnessButton = TextButton(
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
                ceremonyButton,
                busnessButton,
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
