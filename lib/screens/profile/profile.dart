import 'package:flutter/material.dart';
import 'package:sherekoo/screens/profile/myCrmn.dart';
import 'package:sherekoo/screens/profile/settings.dart';
import 'package:sherekoo/widgets/imgWigdets/defaultAvater.dart';
import '../../model/allData.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/util.dart';
import '../../widgets/imgWigdets/userAvater.dart';
import '../accounts/login.dart';
import '../drawer/navDrawer.dart';
import '../hireRequset/invit.dart';
import 'myBusness.dart';
import 'myPosts.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Preferences _preferences = Preferences();
  String token = '';

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
      meritalStatus: '');

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

    super.initState();
  }

  getUser(String dirUrl) async {
    AllUsersModel(payload: [], status: 0).get(token, dirUrl).then((value) {
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
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: topBar(),
        drawer: const NavDrawer(),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0, right: 8.0),
              child: topProfile(),
            ),

            const SizedBox(height: 8),

            //button edit Profile
            profileSetting(context),

            const SizedBox(
              height: 8,
            ),

            //default tab Controller
            const TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Posts',
                  ),
                  Tab(
                    text: 'Ceremony',
                  ),
                ]),

            Expanded(
              child: TabBarView(children: [
                // My Posts

                MyPosts(
                  user: user,
                ),

                // My Ceremonies
                MyCrmn(
                  userId: user.id,
                )
              ]),
            ),
          ],
        ),

        // Bottom Section
        // bottomNavigationBar: const BttmNav(),
      ),
    );
  }

  AppBar topBar() {
    return AppBar(
      backgroundColor: Colors.black54,
      title: const Text('Profile'),
      centerTitle: true,
      actions: [
        // Notification
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const InvitationTime()));
          },
          child: Container(
              padding: const EdgeInsets.only(right: 8.0),
              child: const Icon(Icons.notifications)),
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
        Row(
          children: [
            //Avater
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: user.avater != ''
                  ?
                  // User Current Avater
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: UserAvater(
                        avater: user.avater,
                        url: '/profile/',
                        username: user.username,
                        width: 60.0,
                        height: 60.0,
                      ))
                  : const DefaultAvater(height: 60, radius: 35, width: 60),
            ),

            //username && Followers
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                children: [
                  //Username
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, top: 4),
                    child: Text(
                      '@' + user.username,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  //follewers & followings
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6.0, right: 4, top: 4, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //following
                        Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: const [
                              Text(' 34 ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 24
                                  )),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('following',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14))
                            ],
                          ),
                        ),

                        const SizedBox(
                          width: 15,
                        ),

                        //followers
                        Row(
                          children: const [
                            Text('899 ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 24
                                )),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text('followers',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        //Likes
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: const [
                  Text('34',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(' Likes ',
                      style: TextStyle(color: Colors.grey, fontSize: 14))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Profile Settings
  Row profileSetting(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return MyBusness(user: user);
            }));
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5.0)),
              child: const Text(
                'Busness',
                style: TextStyle(color: Colors.black, fontSize: 16),
              )),
        ),

        // Dispaly all Gallalery & upload function
        user.isCurrentUser == true
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProfileSetting(user: user)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: const Icon(Icons.camera_alt)),
                ),
              )
            : const SizedBox(),
        user.isCurrentUser == true
            ? GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: const Icon(Icons.settings)),
              )
            : const SizedBox(),
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
              //   Navigator.of(context).pop();
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (BuildContext context) => UpdateAvater(
              //                 data: currentUser,
              //               )));
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
}
