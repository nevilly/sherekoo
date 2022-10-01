import 'dart:convert';

import 'package:http/http.dart' as http;

class Services {
  final String svId;
  final String busnessId;
  final String hId;
  final String ceremonyId;
  final String payed;
  final String createdBy;
  final String type;
  //ceremony Type

  late final dynamic status;
  dynamic payload;

  Services(
      {required this.svId,
      required this.hId,
      required this.busnessId,
      required this.payed,
      required this.ceremonyId,
      required this.createdBy,
      required this.type,
      required this.status,
      required this.payload});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      status: json['status'],
      payload: json['payload'],
      svId: json['svId'] ?? "",
      hId: json['hId'] ?? "",
      payed: json['payed'] ?? "",
      busnessId: json['busnessId'] ?? "",
      ceremonyId: json['ceremonyId'] ?? "",
      createdBy: json['createdBy'] ?? "",
      type: json['type'] ?? "",
    );
  }

  Future<Services> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Services.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'hostId': svId,
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
        return Services.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return Services.fromJson({'status': false});
    });
  }

  Future<Services> getInvataions(String token, String dirUrl, id) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Services.fromJson({
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
        return Services.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return Services.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  // Real SERVICES LIFE
  Future<Services> addService(
      String token, String dirUrl, String rId, String payedStatus) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Services.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'busnessId': busnessId,
        'ceremonyId': ceremonyId,
        'payedStatus': payedStatus,
        'requestId': rId
      };
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      print(r.body);
      if (r.statusCode == 200) {
        return Services.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return Services.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<Services> getService(String token, String dirUrl, String id) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Services.fromJson({
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
      // print(r.body);
      if (r.statusCode == 200) {
        return Services.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return Services.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }

  Future<Services> removeService(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    if (token.isEmpty) {
      return Services.fromJson({
        "status": 204,
        "payload": {"error": "Invalid token"}
      });
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': svId};
    }

    Map<String, String> headers = {
      "Authorization": "Owesis $token",
      "Content-Type": "Application/json"
    };

    return await http
        .post(url, body: jsonEncode(toMap()), headers: headers)
        .then((r) {
      if (r.statusCode == 200) {
        return Services.fromJson(
            {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
      }
      return Services.fromJson(
          {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
    });
  }
}
