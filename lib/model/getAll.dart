import 'dart:convert';

import 'package:http/http.dart' as http;

class GetAll {
  final String id;
  final int status;
  dynamic payload;

  GetAll({required this.id, required this.status, required this.payload});

  factory GetAll.fromJson(Map<String, dynamic> json) {
    return GetAll(
        status: json['status'],
        payload: json['payload'] ?? "",
        id: json['id'] ?? "");
  }

  Future<GetAll> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return GetAll.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'id': id,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      // print('check Boody');
      // print(jsonDecode(r.body)['payload']);

      if (r.statusCode == 200) {
        return GetAll.fromJson({
          'id': '',
          'status': r.statusCode,
          'payload': jsonDecode(r.body)['payload']
        });
      } else {
        return GetAll.fromJson({
          'id': '',
          'status': r.statusCode,
          'payload': jsonDecode(r.body)['payload']
        });
      }
    });
  }
}
