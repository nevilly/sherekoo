import 'dart:convert';

import 'package:http/http.dart' as http;

class BsnCall {
  final int status;
  dynamic payload;

  BsnCall(
    
    {required this.payload, required this.status}
    
    );

  factory BsnCall.fromJson(Map<String, dynamic> json) {
    return BsnCall(payload: json['payload'], status: json['status']);
  }

  Future<BsnCall> get(String token, String dirUrl) async {
    Uri url = Uri.parse(dirUrl);

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return getHttp(url, headers);
  }

  Future<BsnCall> onGoldenBusness(
      String token, String dirUrl, String bsnType, String id) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': id, 'type': bsnType};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BsnCall> myBusness(String token, String dirUrl, String bsnType) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'type': 'My_Busness', 'ceoId': bsnType};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BsnCall> bsnByCreatorid(
      String token, String dirUrl, String userId) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': userId};
    }

    invalidToken(token);
    Map<String, String> headers = myHttpHeaders(token);
    return postHttp(url, toMap, headers);
  }

  Future<BsnCall> deleteBsn(String token, String dirUrl, String bId) async {
    Uri url = Uri.parse(dirUrl);

    Map<String, dynamic> toMap() {
      return <String, dynamic>{'id': bId};
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
    return BsnCall.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}

Future<BsnCall> postHttp(Uri url, Map<String, dynamic> Function() toMap,
    Map<String, String> headers) async {
  return await http
      .post(url, body: jsonEncode(toMap()), headers: headers)
      .then((r) {
    print('categories Details');
    print(r.body);
    if (r.statusCode == 200) {
      return rBody(r);
    }
    return rBody(r);
  });
}

Future<BsnCall> getHttp(Uri url, Map<String, String> headers) async {
  return await http.get(url, headers: headers).then((r) {
    if (r.statusCode == 200) {
      return rBody(r);
    } else {
      return rBody(r);
    }
  });
}

BsnCall rBody(http.Response r) {
  return BsnCall.fromJson(
      {'status': r.statusCode, 'payload': jsonDecode(r.body)['payload']});
}
