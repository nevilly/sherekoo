import 'dart:convert';
import 'package:http/http.dart' as http;

class AllUsersModel {
  final int status;
  dynamic payload;

  AllUsersModel({required this.payload, required this.status});

  factory AllUsersModel.fromJson(Map<String, dynamic> json) {
    return AllUsersModel(payload: json['payload'], status: json['status']);
  }

  Future<AllUsersModel> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return AllUsersModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http.get(url, headers: headers).then((http.Response r) {
      if (r.statusCode == 200) {
        print(r.body);
        return AllUsersModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return AllUsersModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<AllUsersModel> getUserById(
      String token, String dirUrl, String id) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return AllUsersModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id};
    }

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return AllUsersModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return AllUsersModel.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }
}
