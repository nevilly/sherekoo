import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sherekoo/screens/profile/profile.dart';
import '../../model/authentication/loginModel.dart';
import '../../model/profileMode.dart';
import '../../util/Preferences.dart';
import '../../util/pallets.dart';
import '../../util/util.dart';
import '../../widgets/login_widget/background-image.dart';

import '../home.dart';
import 'create-new-account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      lastname: '', isCurrentUser: '');

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
                builder: (BuildContext context) => const Home(),
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
                    builder: (BuildContext context) => Profile(
                          user: currentUser,
                        )),
                ModalRoute.withName('/'));
          });
        } else {
          infoError("System Error, Wrong password or phone number..");
        }
      } else {
        infoError('Insert password, Is empty..');
      }
    } else {
      infoError('Insert password, Is empty..');
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
              const Flexible(
                child: Center(
                  child: Text(
                    'Cherekoo',
                    style: TextStyle(
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
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.phone_android,
                                size: 28,
                                color: kWhite,
                              ),
                            ),
                            hintText: 'Phone Number',
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
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.lock,
                                size: 28,
                                color: kWhite,
                              ),
                            ),
                            hintText: 'Password',
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
                    child: const Text(
                      'Forgot Password',
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
                        'Login',
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
                  child: const Text(
                    'Create New Account',
                    style: kBodyText_login,
                  ),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Colors.lightBlue))),
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
