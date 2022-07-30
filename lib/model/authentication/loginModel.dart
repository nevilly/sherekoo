import 'dart:convert';
import "package:http/http.dart" as http;

class LoginModel {
  final String username;
  final String password;
  final String? token;
  final dynamic status;

  LoginModel(
      {required this.password,
      required this.status,
      required this.token,
      required this.username});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      token: json['payload'],
      password: '',
      username: '',
    );
  }

  Future postLoging(l) async {
    Uri url = Uri.parse(l);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'username': username, 'password': password};
    }

    return await http.post(url,
        body: jsonEncode(toMap()),
        headers: {"content-Type": "application/json"}).then((http.Response r) {
      final rJson = jsonDecode(r.body);

      if (r.statusCode == 200) {
        return LoginModel.fromJson(rJson);
      }
      return LoginModel.fromJson({'status': false});
    });
  }
}
