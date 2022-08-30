import 'dart:convert';

import 'package:http/http.dart' as http;

class SvPost {
  final String hostId;
  final String busnessId;
  final String ceremonyId;
  final String contact;
  final String createdBy;
  final String type;
  //ceremony Type

  late final dynamic status;
  dynamic payload;

  SvPost(
      {required this.hostId,
      required this.busnessId,
      required this.contact,
      required this.ceremonyId,
      required this.createdBy,
      required this.type,
      required this.status,
      required this.payload});

  factory SvPost.fromJson(Map<String, dynamic> json) {
    return SvPost(
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

  Future<SvPost> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return SvPost.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'hostId': hostId,
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
        return SvPost.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return SvPost.fromJson({'status': false});
    });
  }

  Future<SvPost> post(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return SvPost.fromJson({
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
        return SvPost.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return SvPost.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<SvPost> getInvataions(String token, String dirUrl, id) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return SvPost.fromJson({
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
        return SvPost.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return SvPost.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }
}
