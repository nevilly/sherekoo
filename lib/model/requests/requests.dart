import 'dart:convert';

import 'package:http/http.dart' as http;

class Requests {
  final String hostId;
  final String busnessId;
  final String ceremonyId;
  final String contact;
  final String createdBy;
  final String type;
  //ceremony Type

  late final dynamic status;
  dynamic payload;

  Requests(
      {required this.hostId,
      required this.busnessId,
      required this.contact,
      required this.ceremonyId,
      required this.createdBy,
      required this.type,
      required this.status,
      required this.payload});

  factory Requests.fromJson(Map<String, dynamic> json) {
    return Requests(
      status: json['status'],
      payload: json['payload'],
      hostId: json['hostId'] ?? "",
      busnessId: json['busnessId'] ?? "",
      ceremonyId: json['ceremonyId'] ?? "",
      createdBy: json['createdBy'] ?? "",
      contact: json['contact'] ?? "",
      type: json['type'] ?? "",
    );
  }

  Future<Requests> post(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Requests.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'busnessId': busnessId,
        'ceremonyId': ceremonyId,
        'createdBy': createdBy,
        'contact': contact,
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      // final rJson = jsonDecode(r.body);
      
      if (r.statusCode == 200) {
        return Requests.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return Requests.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<Requests> getGoldenRequest(String token, String dirUrl, id) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Requests.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'type': type};
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      // final rJson = jsonDecode(r.body);
      if (r.statusCode == 200) {
        // final my = jsonDecode(""" ${r.body} """);
        // print(r.body);
        // print('jsonDecodeeee');
        // print(my);
        return Requests.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return Requests.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<Requests> cancelRequest(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Requests.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': hostId};
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
     
      if (r.statusCode == 200) {
        return Requests.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return Requests.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<Requests> updateRequest(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Requests.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': hostId};
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return Requests.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return Requests.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }
}
