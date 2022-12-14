import 'dart:convert';

import 'package:http/http.dart' as http;

class ServicesCall {
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

  ServicesCall(
      {required this.svId,
      required this.hId,
      required this.busnessId,
      required this.payed,
      required this.ceremonyId,
      required this.createdBy,
      required this.type,
      required this.status,
      required this.payload});

  factory ServicesCall.fromJson(Map<String, dynamic> json) {
    return ServicesCall(
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

  Future<ServicesCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'hostId': svId,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<ServicesCall> getInvataions(String token, String dirUrl, id) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'type': type};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  // Real SERVICES LIFE
  Future<ServicesCall> addService(
      String token, String dirUrl, String rId, String payedStatus) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'busnessId': busnessId,
        'ceremonyId': ceremonyId,
        'payedStatus': payedStatus,
        'requestId': rId
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<ServicesCall> getService(
      String token, String dirUrl, String id) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'type': type};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<ServicesCall> removeService(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': svId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }
}

/// External Function
Map<String, String> myHttpHeaders(String token) {
  return {"Authorization": "Owesis $token", "Content-Type": "Application/json"};
}

invalidToken(token) {
  if (token.isEmpty) {
    return ServicesCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<ServicesCall> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<ServicesCall> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

ServicesCall rBody(http.Response r) {
  return ServicesCall.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
