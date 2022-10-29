import 'package:sherekoo/util/appWords.dart';

class English {
  English(this.key) : super();
  final int key;
  List dictionary = [
    "Sherekoo", // 0
    // Login & Registration LIfe
    "Phone Number", // 1
    "Password",
    "Forget Password",
    "Login",
    "Create New Account", // 5
    "Wrong Phone number or Password..",
    "Insert password... ",
    "Insert Phone Number ...",
    "username",
    'Male', //10
    "Female",
    "Register",
    "Sorry a user with the same information exists on our system. Please login!",
    "Select Gender Please...",
    "Enter your Username Please...", // 15
    "Already have an account..? ",
    "TigoPesa",
    "Airtel Money",
    "cancel",
    "", //20
    "TRANSACTIONS HISTORY",
    "ALL",
    "Congraturation",
    "",
    "LOGIN", //25
    "SIGN UP",
    "SIGN IN",
    "Plot listing, properties, real estate",
    "Register your orphanage for better health services",
    "Back", //30
    "Submit",
    et, //  32
    tst,
    es,
    sno, //35
    ee,
    epno,
    wd,
    ds,
    rd, //40
    sj,
    sStar,
    imgInsertAlt,
    titleAlt,
    eidt, //45
    ei
  ];

  words() {
    return dictionary[key];
  }
}
