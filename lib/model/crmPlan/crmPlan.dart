import 'dart:convert';

import 'package:http/http.dart' as http;

class CrmPlan {
  dynamic status;
  dynamic payload;

  CrmPlan({required this.payload, required this.status});

  factory CrmPlan.fromJson(Map<String, dynamic> json) {
    return CrmPlan(payload: json['payload'], status: json['status']);
  }

  Future<CrmPlan> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmPlan.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http.get(url, headers: headers).then((r) {
      if (r.statusCode == 200) {
        return CrmPlan.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmPlan.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmPlan> updateBundle(String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmPlan.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'position': position};
    }

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((http.Response r) {
      if (r.statusCode == 200) {
        return CrmPlan.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmPlan.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmPlan> removeCard(String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmPlan.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'userId': userId};
    }

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((http.Response r) {
      // print(r.body);
      if (r.statusCode == 200) {
        return CrmPlan.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmPlan.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  
 
}
