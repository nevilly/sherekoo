import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sherekoo/util/Locale.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/user/user-call.dart';
import '../../model/authentication/creatAccount.dart';
import '../../model/user/userModel.dart';
import '../../util/Preferences.dart';
import '../../util/pallets.dart';
import '../../util/util.dart';
import '../../widgets/login_widget/background-image.dart';
import 'add-profile.dart';
import 'login.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  bool isSwahili = true, isVisibleDrawer = true, r = false;
  final Preferences _preferences = Preferences();
  String u = '';
  String token = '';
  User currentUser = User(
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
  bool isLoggedIn = false;
  // String _email;
  //String _password;
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  //gender List
  List gender = ["Male", "Female"];
  String select = "";

  // merital Status...
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: prmry,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              // print(value);
              select = value!;
            });
          },
        ),
        Text(title, style: kBodyText)
      ],
    );
  }

  @override
  void initState() {
    _preferences.init().then((data) {
      u = data.getString('token');

      isLoggedIn = u.isNotEmpty;
      // if (isLoggedIn) {
      //   SchedulerBinding.instance!.addPostFrameCallback((_) {
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(
      //           builder: (BuildContext context) => const Home(),
      //         ),
      //         ModalRoute.withName('/'));
      //   });
      // }
    });
    super.initState();
  }

  emptyField(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void creatAccount(us, ph, p, g) async {
    if (us.isNotEmpty) {
      if (ph.isNotEmpty) {
        if (p.isNotEmpty) {
          if (g.isNotEmpty) {
            final CreateAccountModel r = await CreateAccountModel(
                    password: password.text,
                    status: 0,
                    token: '',
                    avater: '',
                    username: username.text,
                    phone: phone.text,
                    gender: select,
                    address: '',
                    bio: '',
                    email: '',
                    firstname: '',
                    role: 'n',
                    lastname: '',
                    meritalStatus: '')
                .registerAccount();

            if (r.status == 200) {
              setState(() {
                _preferences.add('token', r.token);
                emptyField(" $us was added successful!...");

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CompleteProfile()),
                    ModalRoute.withName('/'));
              });
            } else {
              if (r.token ==
                  "Sorry a user with the same information exists on our system. Please login!") {
                emptyField(OLocale(isSwahili, 13).get());
              } else {
                emptyField('System Error, Try Again');
              }
            }
          } else {
            emptyField(OLocale(isSwahili, 14).get());
          }
        } else {
          emptyField(OLocale(isSwahili, 8).get());
        }
      } else {
        emptyField(OLocale(isSwahili, 7).get());
      }
    } else {
      emptyField(OLocale(isSwahili, 15).get());
    }
  }

  getUser(tokenn) async {
    UsersCall(payload: [], status: 0).get(tokenn, urlGetUser).then((value) {
      setState(() {
        currentUser = User.fromJson(value.payload);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // ignore: prefer_const_constructors
        BackgroundImage(image: 'assets/login/02.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.width * 0.1,
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.red.withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              Icons.person_off_outlined,
                              //FontAwesomeIcons.user,
                              color: kWhite,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: prmry,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhite, width: 2),
                        ),
                        child: const Icon(
                          Icons.arrow_upward,
                          //FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    //Enter Name
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextField(
                            controller: username,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(
                                  Icons.person,
                                  size: 28,
                                  color: kWhite,
                                ),
                              ),
                              hintText: OLocale(isSwahili, 9).get(),
                              hintStyle: kBodyText,
                            ),
                            // obscureText: true,
                            style: kBodyText,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,

                            onChanged: (value) {
                              setState(() {
                                //_email = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    //Enter Phone
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextField(
                            controller: phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(
                                  Icons.phone_android,
                                  size: 28,
                                  color: kWhite,
                                ),
                              ),
                              hintText: OLocale(isSwahili, 1).get(),
                              hintStyle: kBodyText,
                            ),
                            // obscureText: true,
                            style: kBodyText,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,

                            onChanged: (value) {
                              setState(() {
                                //_email = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    //Enter Password
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextField(
                            controller: password,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(
                                  Icons.lock,
                                  size: 28,
                                  color: kWhite,
                                ),
                              ),
                              hintText: OLocale(isSwahili, 2).get(),
                              hintStyle: kBodyText,
                            ),
                            obscureText: true,
                            style: kBodyText,
                            // keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              setState(() {
                                //_email = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    // Radio Button
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          addRadioButton(0, OLocale(isSwahili, 10).get()),
                          addRadioButton(1, OLocale(isSwahili, 11).get()),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //Register Button
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: prmry,
                      ),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () => creatAccount(
                            username.text, phone.text, password.text, select),
                        child: Text(
                          OLocale(isSwahili, 12).get(),
                          style:
                              kBodyText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          OLocale(isSwahili, 16).get(),
                          style: kBodyText_login,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginPage())),
                          child: Text(
                            ' Login',
                            style: kBodyText.copyWith(
                                color: prmry, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
