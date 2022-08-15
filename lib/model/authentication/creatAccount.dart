import 'dart:convert';
import "package:http/http.dart" as http;

import '../../util/util.dart';

class CreateAccountModel {
  final String username;
  final String avater;
  final String firstname;
  final String lastname;
  final String email;
  final String address;
  final String password;
  final String phone;
  final String gender;
  final String meritalStatus;
  final String bio;
  final String role;
  final String? token;

  final int status;

  CreateAccountModel(
      {required this.firstname,
      required this.avater,
      required this.lastname,
      required this.email,
      required this.address,
      required this.bio,
      required this.password,
      required this.status,
      required this.token,
      required this.gender,
      required this.meritalStatus,
      required this.phone,
      required this.role,
      required this.username});

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) {
    return CreateAccountModel(
      status: json['status'],
      token: json['payload'],
      password: '',
      username: '',
      avater: '',
      role: '',
      gender: '',
      phone: '',
      address: '',
      bio: '',
      email: '',
      firstname: '',
      lastname: '',
      meritalStatus: '',
    );
  }

  Future registerAccount() async {
    Uri url = Uri.parse(craetAcount);
    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'username': username,
        'password': password,
        'gender': gender,
        'phone': phone,
        'address': address,
        'bio': bio,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'role': role
      };
    }

    return await http.post(url,
        body: jsonEncode(toMap()),
        headers: {"content-Type": "application/json"}).then((http.Response r) {
      final rJson = jsonDecode(r.body);

      if (r.statusCode == 200) {
        return CreateAccountModel.fromJson(rJson);
      }
      return CreateAccountModel.fromJson(rJson);
    });
  }

  Future updateAccount(String token, dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CreateAccountModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'firstname': firstname,
        'lastname': lastname,
        'meritalStatus': meritalStatus,
        'address': address,
        'avater': avater
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http
        .put(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      final rJson = jsonDecode(r.body);

      if (r.statusCode == 200) {
        return CreateAccountModel.fromJson(rJson);
      }
      return CreateAccountModel.fromJson(rJson);
    });
  }

  Future updateAccountSetting(String token, dirUrl, String normalAvater) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CreateAccountModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'phoneNo': phone,
        'meritalStatus': meritalStatus,
        'address': address,
        'avater': avater,
        'normalAvater': normalAvater
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http
        .put(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      final rJson = jsonDecode(r.body);

      if (r.statusCode == 200) {
        return CreateAccountModel.fromJson(rJson);
      }
      return CreateAccountModel.fromJson(rJson);
    });
  }
}
