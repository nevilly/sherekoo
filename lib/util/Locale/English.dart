// ignore: file_names
// ignore_for_file: file_names

class English {
  English(this.key) : super();
  final int key;
  List dictionary = [
    "Sherekoo", // 1
    "Phone Number",
    "Password",
    "Forget Password",
    "Login", //5
    "Create New Account",
    "Wrong Phone number or Password..",
    "Insert password... ",
    "Insert Phone Number ...",
    "", // 10
    'Change language',
    "",
    "",
    "Cancel",
    "Select payment method",
    "paypal",
    "M-Pesa",
    "TigoPesa",
    "Airtel Money",
    "",
    "",
    "TRANSACTIONS HISTORY",
    "ALL",
    "",
    "",
    "LOGIN",
    "SIGN UP",
    "SIGN IN",
    "Plot listing, properties, real estate",
    "Register your orphanage for better health services",
    "Back",
    "Submit",
  ];

  words() {
    return dictionary[key];
  }
}
