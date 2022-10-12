import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../model/authentication/loginModel.dart';
import '../../model/userModel.dart';
import '../../util/Locale.dart';
import '../../util/Preferences.dart';
import '../../util/pallets.dart';
import '../../util/util.dart';
import '../../widgets/login_widget/background-image.dart';

import '../homNav.dart';
import 'create-new-account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSwahili = false, isVisibleDrawer = true, r = false;
  final Preferences _preferences = Preferences();
  String u = '';
  bool isLoggedIn = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  User currentUser = User(
      id: '',
      username: '',
      avater: '',
      phoneNo: '',
      role: '',
      gender: '',
      email: '',
      firstname: '',
      lastname: '',
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
    _preferences.init().then((data) {
      u = data.getString('token');

      isLoggedIn = u.isNotEmpty;
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomeNav(
                  getIndex: 2,
                  user: currentUser,
                ),
              ),
              ModalRoute.withName('/'));
        });
      }
    });
    super.initState();
  }

  infoError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void getLogin() async {
    if (username.text.isNotEmpty) {
      if (password.text.isNotEmpty) {
        infoError("Login....");
        final LoginModel r = await LoginModel(
                password: '123456', //password.text, //
                status: 0,
                token: '',
                username: '0686111111') //username.text) //
            .postLoging(login);
        if (r.status == 200) {
          setState(() {
            _preferences.add('token', r.token);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeNav(
                          user: currentUser,
                          getIndex: 2,
                        )),
                ModalRoute.withName('/'));
          });
        } else {
          infoError(OLocale(isSwahili, 6).get());
        }
      } else {
        infoError(OLocale(isSwahili, 7).get());
      }
    } else {
      infoError(OLocale(isSwahili, 8).get());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const BackgroundImage(image: "assets/login/03.jpg"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    OLocale(false, 0).get(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                children: [
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
                          // keyboardType: inputType,
                          // textInputAction: inputAction,

                          onChanged: (value) {
                            setState(() {
                              //_email = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  //forgot Password
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
                    child: Text(
                      OLocale(false, 3).get(),
                      style: kBodyText_login,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //Login Button
                  Container(
                    height: size.height * 0.08,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: kRed,
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        getLogin();
                      },
                      child: Text(
                        OLocale(isSwahili, 4).get(),
                        style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CreateNewAccount())),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Colors.lightBlue))),
                  child: Text(
                    OLocale(false, 5).get(),
                    style: kBodyText_login,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
