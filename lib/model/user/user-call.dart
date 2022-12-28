import 'dart:convert';
import 'package:http/http.dart' as http;

class UsersCall {
  final int status;
  dynamic payload;

  UsersCall({required this.payload, required this.status});

  factory UsersCall.fromJson(Map<String, dynamic> json) {
    return UsersCall(payload: json['payload'], status: json['status']);
  }

  Future<UsersCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return UsersCall.fromJson({
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
        // print('checkkk vzuriii hapaaa');
        // print(r.body);
        return UsersCall.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return UsersCall.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<UsersCall> getUserById(
      String token, String dirUrl, String id) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return UsersCall.fromJson({
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
        return UsersCall.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return UsersCall.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }
}
