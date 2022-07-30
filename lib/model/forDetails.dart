import 'dart:convert';

import 'package:http/http.dart' as http;

class ForDetailsModel {
  final int status;
  dynamic payload;

  ForDetailsModel({required this.payload, required this.status});

  factory ForDetailsModel.fromJson(Map<String, dynamic> json) {
    return ForDetailsModel(payload: json['payload'], status: json['status']);
  }

  Future<ForDetailsModel> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return ForDetailsModel.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis " + token,
      "Content-Type": "Application/json"
    };

    return await http.get(url, headers: headers).then((r) {
      if (r.statusCode == 200) {
        // print(jsonDecode(r.body)['payload']);
        return ForDetailsModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return ForDetailsModel.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }
}
