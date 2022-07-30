import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  bool isLoggedIn() {
    String token = '';
    init().then((prefs) {
      if (prefs != null && prefs.getString('token') != null) {
        token = prefs.getString('token');
      }
      return token.isNotEmpty;
    });
    return token.isNotEmpty;
  }

  add(key, value) {
    // isInt(value)
    //     ?
    //     print('am interger')
    //     init().then((sp) => sp.setInt(key, value))
    //     : init().then((sp) => sp.setString(key, value));

    if (isInt(value)) {
      init().then((sp) => sp.setInt(key, value));
    } else {
      init().then((sp) => sp.setString(key, value));
    }
  }

  Future<dynamic> get(key) async {
    return init().then((sp) {
      // is sp token as get parameter
      if (!isInt(prefs.getString(key))) {
        return prefs.getString(key);
      } else {
        return prefs.getInt(key);
      }
    });
  }

  Future<Map<dynamic, dynamic>> getUserInfo() async {
    Map mp = {};
    mp['user'] = init().then((sp) {
      mp['username'] = sp.getString('username');
      mp['token'] = sp.getString('token');
    });
    return mp;
  }

  bool isInt(value) => value is int;

  Future<dynamic> logout() async {
    return init().then((prefs) {
      return prefs.clear();
    });
  }
}
