// ignore: file_names
// ignore_for_file: file_names

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
