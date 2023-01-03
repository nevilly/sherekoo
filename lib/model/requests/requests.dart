import 'dart:convert';

import 'package:http/http.dart' as http;

class Requests {
  String? hostId;
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

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        'busnessId': busnessId,
        'ceremonyId': ceremonyId,
        'createdBy': createdBy,
        'contact': contact,
      };
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<Requests> getGoldenRequest(String token, String dirUrl, id) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'type': type};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);

    return postHttp(url, toMap, headers);
  }

  Future<Requests> cancelRequest(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': hostId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<Requests> updateRequest(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': hostId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }
}

//// External Function
Map<String, String> myHttpHeaders(String token) {
  return {"Authorization": "Owesis $token", "Content-Type": "Application/json"};
}

invalidToken(token) {
  if (token.isEmpty) {
    return Requests.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<Requests> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    // print(r.body); // Debbuger
    if (r.statusCode == 200) {
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<Requests> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

Requests rBody(http.Response r) {
  // print(jsonDecode(r.body)['payload']);
  return Requests.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
