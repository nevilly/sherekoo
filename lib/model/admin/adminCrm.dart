import 'dart:convert';

import 'package:http/http.dart' as http;

class AdminCrmModel {
  dynamic status;
  dynamic payload;

  AdminCrmModel({required this.payload, required this.status});

  factory AdminCrmModel.fromJson(Map<dynamic, dynamic> json) {
    return AdminCrmModel(payload: json['payload'], status: json['status']);
  }

  Future<AdminCrmModel> getCeremonyByUserId(
      String token, String dirUrl, String userId) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return AdminCrmModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'userId': userId,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((http.Response r) {
      if (r.statusCode == 200) {
        print(r.body);
        return AdminCrmModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return AdminCrmModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }
}
