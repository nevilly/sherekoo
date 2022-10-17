import 'dart:convert';

import 'package:http/http.dart' as http;

class CrmServers {
  dynamic status;
  dynamic payload;

  CrmServers({required this.payload, required this.status});

  factory CrmServers.fromJson(Map<String, dynamic> json) {
    return CrmServers(payload: json['payload'], status: json['status']);
  }

  Future<CrmServers> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmServers.fromJson({
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
        return CrmServers.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmServers.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmServers> updateServers(String token, String dirUrl, id, position) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmServers.fromJson({
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
        return CrmServers.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmServers.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  Future<CrmServers> removeCard(String token, String dirUrl, id, userId) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return CrmServers.fromJson({
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
        return CrmServers.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      } else {
        return CrmServers.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
    });
  }

  
 
}
